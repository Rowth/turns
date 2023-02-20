// ignore_for_file: deprecated_member_use

import 'package:driver/controllers/home_controller.dart';
import 'package:driver/services/networking_services/api_call.dart';
import 'package:driver/services/response_models/driver_stop_response_model.dart';
import 'package:driver/utils/localization/loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localization/SharedPrefKeys.dart';
import '../utils/localization/app_colors.dart';
import '../utils/localization/images_paths.dart';
import '../utils/localization/print_data.dart';
import '../utils/routes/my_routes.dart';

class MapsWithRoutesControllers extends GetxController {
  List<DriverStopListData> driverStopsList = [];
  final ScrollController listViewController = ScrollController();
  SnappingSheetController sheetController = SnappingSheetController();
  HomeController homeController = Get.find();
  String title = "";
  RxString routeName = "Route Name".obs;
  RxString timings = "Time".obs;
  RxString totalStops = "13".obs;
  bool hasRoutes = false;
  String routeID = "";
  String updateListKey = "updateListKey";
  RxString totalDistance = "1000 Km".obs;
  final GlobalKey<ScaffoldState> keys = GlobalKey();
  TextEditingController messageController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final CameraPosition initialCam = const CameraPosition(
    target: LatLng(37.42342342342342, -122.3745876),
    zoom: 18.4746,
  );
  int size = 0;
  RxInt selectedIndex = (-1).obs;
  String messageToBeSent = "";
  String userName = "";
  String userPhone = "";
  RxBool checkboxValue = false.obs;
  RxBool allStopsCompleted = false.obs;
  RxBool hasBeenCancelled = false.obs;
  RxBool message = false.obs;
  RxInt click = (-1).obs;
  RxList<String> titlesList = <String>[].obs;
  String driverLat = "";
  RxBool isRouteStarted = false.obs;
  String driverLong = "";
  RxString routeType = "".obs;
  List<String> titles = [
    "Delivery will be take time because\nstuck in traffic.",
    "Delivery will be take time because\ndelivery truck broke on the way.",
    "Delivery will done in 5 min",
    "Delivery will done in 10 min",
    "Delivery will done in 15 min",
    "Delivery will be late for today",
  ];

  // Required for particular stops
  String status = "";
  String stopID = "";
  RxString stopNote = "".obs;

  void stopDetailsAPI(request) {
    CallAPI().driverStopDetails(request).then((value) {
      Get.back();
      if(value.stopData?.stopStatus=="0"){
        hasBeenCancelled.value = false;
      } else{
        hasBeenCancelled.value = true;
      }

      if (value.status == true) {
        stopNote.value = "${value.stopData?.driverNotes}";
        stopDetailBottomSheet(
          routeName: "${value.stopData?.routeName}",
          status: status,
          notes: stopNote.value,
          stopID: stopID,
          distance: "${value.stopData?.distance}",
          timing: formatTime("${value.stopData?.estTime}"),
          customerAddress: "${value.stopData?.customerAddress}",
          outOfStops: "${value.stopData?.routeName}",
          lat: "${value.stopData?.userLat}",
          long: "${value.stopData?.userLng}",
          userPhone:
              "${value.stopData!.customerMobileCode}-${value.stopData?.customerMobile}",
          userName: "${value.stopData?.customerName}",
          bags: "${value.stopData?.totalBag}",
          weight: "${value.stopData?.weights}",
          pieces: "${value.stopData?.pieces}",
        );
      } else {}
    }).onError((error, stackTrace) {
      Get.back();
    });
  }

  Future<bool> getBackToHome() async {
    Get.offAllNamed(MyRoutes.getBackHomeUI);
    return true;
  }

  @override
  void onInit() {
    routeID = homeController.routeID;
    routeType.value = homeController.routeType;
    getUserData();
    getStopLists(ApiFrom.none);
    title = homeController.selectedStore.value;
    super.onInit();
  }

  void showRouteNotStartedWarning() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (ctx) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0)),
            child: SizedBox(
              height: 230,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2)),
                      child: Image.asset(
                        ImagesPaths.icWarning,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    "Route not started yet !"
                        .text
                        .fontWeight(FontWeight.w600)
                        .make()
                        .py(20),
                    Container(
                      height: 40,
                      width: Get.width * .6,
                      decoration: BoxDecoration(
                          color: Colors.green.shade800,
                          borderRadius: BorderRadius.circular(7)),
                      child: "Ok".text.color(Colors.white).make().centered(),
                    ).onTap(() {
                      Get.back();
                    }),
                  ]),
            )));
  }

  void getUserData() {
    GetStorage storage = GetStorage();
    userName = storage.read(SharedPrefrencesKeys.USER_NAME) ?? "Driver Name";
    userPhone = storage.read(SharedPrefrencesKeys.USER_PHONE) ?? "Driver Phone";

    homeController.routeStatus == RouteStatus.running
        ? isRouteStarted.value = true
        : isRouteStarted.value = false;
  }

  String formatTime(String time) {
    return DateFormat.jm()
        .format(DateFormat('hh:mm').parse(time))
        .toUpperCase();
  }

  void isChecked() {
    checkboxValue.value = !checkboxValue.value;
    printData(checkboxValue.value);
  }

  ///==== function note bottom sheet =====///
  void showNotes(String notesMessage, String stopID) {
    stopNote.value = notesMessage;
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.89,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImagesPaths.icNoPlasticBags,
                      height: 24,
                    ).p(10),
                    "Add Note".text.fontWeight(FontWeight.w600).size(16).make(),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  color: AppColors.white,
                  child: Image.asset(
                    ImagesPaths.icCross,
                  ).pOnly(bottom: 5),
                ).onTap(() {
                  Get.back();
                }),
              ],
            ).pLTRB(10, 17, 29, 13),
            Container(
              height: Get.height * 0.68,
              width: Get.width * .9,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: notesController,
                maxLines: 100,
                minLines: 100,
                maxLength: 250,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Note",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black)),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ).pOnly(left: 15),
            ).pLTRB(16, 0, 16, 0),
            Container(
              height: 50,
              width: Get.width * .9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(2),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ).pLTRB(80, 24, 80, 22).onTap(() {
              addNotesAPI(stopID);
            }),
          ],
        ),
      ).px(8),
    );
  }

  Future<void> getCurrentLocation(
      GoogleMapController googleMapController) async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      LatLng latLng = LatLng(position.latitude, position.longitude);
      googleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const GetSnackBar(
        title: "",
        message: "Location services are disabled. Please enable the services",
        duration: Duration(seconds: 2),
      ).show();

      printData("Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        const GetSnackBar(
          title: "",
          message: "Location permissions are denied",
          duration: Duration(seconds: 2),
        ).show();

        printData("Location permissions are denied");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      const GetSnackBar(
        title: "",
        message:
            "Location permissions are permanently denied, we cannot request permissions.",
        duration: Duration(seconds: 2),
      ).show();

      printData(
          "Location permissions are permanently denied, we cannot request permissions");

      return false;
    }
    return true;
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchGoogleMap(String latitude, String longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
      ThemeData.dark();
    } else {
      throw 'Could not open the map.';
    }
  }

  void selectMessage(int currentIndex) {
    selectedIndex.value = currentIndex;
    messageToBeSent = titles[selectedIndex.value];
    messageController.clear();
  }

  completeOrFail(
      {required String type, required String method, required String stopID}) {
    showLoader(Get.context);
    var request = {"stop_id": stopID, "type": type};
    CallAPI().updateStopStatus(request).then((value) {
      Get.closeAllSnackbars();
      if (type == "failed") {
        hasBeenCancelled.value = value.status!;
        // print(hasBeenCancelled);
      }

      // method:swipe is for while swiping it from main ui
      // in for the function called by stop detail section
      // if (method != "swipe") {
      //   Get.back();
      // }

      Future.delayed(const Duration(milliseconds: 10)).then((value) {
        Get.back();

        getStopLists(ApiFrom.none);
        // Get.back();
      });
    }).onError((error, stackTrace) {
      Get.back();
    });
  }

  // Encoding sms text to send it through URI component
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Launch message application and send message into it
  Future<void> sendMessage({required String phone}) async {
    Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
      query: encodeQueryParameters(<String, String>{'body': messageToBeSent}),
    );

    try {
      if (await canLaunch(smsUri.toString())) {
        launch(smsUri.toString());
      }
    } catch (e) {
      printData("error sending message");
    }
  }

  void clickStartRoute({required String type}) {
    var request = {"route_id": routeID};
    type == "today"
        ? {
            CallAPI().startRoute(request).then((value) {
              if (value.status == true) {
                isRouteStarted.value = true;
              }
              Get.snackbar(
                "Turns Fleets",
                value.message ?? "Something went wrong",
                snackPosition: SnackPosition.TOP,
              );
            })
          }
        : {};
  }

  void clickCompleteRoute({required String type}) {
    var request = {"route_id": routeID};
    type == "today"
        ? {
            CallAPI().completeRoute(request).then((value) {
              Get.snackbar(
                "Turns Fleets",
                value.message ?? "Something went wrong",
                snackPosition: SnackPosition.TOP,
              );
              Get.closeAllSnackbars();

              if (value.status == true) {
                Get.offAllNamed(MyRoutes.homePageUI);
              }
            })
          }
        : {};
  }

  onTapYesOnLogout() {
    Get.back();
    showLoader(Get.context);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      GetStorage storage = GetStorage();
      storage.erase();
      Get.offAllNamed(MyRoutes.businessIdUI);
    });
  }

  onTapNoOnLogout() {
    Get.back();
  }

  void expandSheet() {
    sheetController.snapToPosition(const SnappingPosition.factor(
      grabbingContentOffset: GrabbingContentOffset.bottom,
      snappingDuration: Duration(seconds: 1),
      positionFactor: 0.8,
    ));
  }

  void getStopLists(ApiFrom type) {
    if (type == ApiFrom.none) {
      Future.delayed(const Duration(microseconds: 1)).then((value) {
        showLoader(Get.context);
      });
    }

    var request = {"route_id": routeID};
    CallAPI().getDriverStopsList(request).then((value) {
      Get.back();
      if (value.status = true) {
        if (value.data.isNotEmpty) {
          driverStopsList = value.data;
          expandSheet();
        } else {
          printData("No stops found");
        }

        List<bool> getVal = [];
        for (int i = 0; i <= driverStopsList.length - 1; i++) {
          printData(i.toString());

          if (driverStopsList[i].stopStatus == "1") {
            getVal.add(true);
          } else {
            getVal.add(false);
          }
        }

        if (getVal.contains(false)) {
          printData("All Routes Not Completed Yet");
          allStopsCompleted.value = false;
        } else {
          printData("All Routes Completed");
          allStopsCompleted.value = true;
        }
        totalStops.value = value.totalStop ?? "0";
        totalDistance.value = value.distance ?? "0";
        routeName.value = value.routeName ?? "Route Name";
        timings.value =
            "${formatTime("${value.routeTimingFrom}")}-${formatTime("${value.routeTimingTo}")}";
        update([updateListKey]);
      } else {
        if (value.message == "Token has expired") {
          CallAPI().getUpdatedToken().then((value) {
            if (value.status == true) {
              GetStorage storage = GetStorage();
              storage
                  .write(SharedPrefrencesKeys.ACCESS_TOKEN_KEY,
                      value.data?.accessToken)
                  .then((value) {
                getStopLists(ApiFrom.none);
              });
            }
          });
        } else {
          Get.closeAllSnackbars();
          Get.snackbar(
            "Turns Fleets",
            value.message ?? "Something went wrong",
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    }).onError((error, stackTrace) {
      printData(error.toString());
      Get.snackbar(
        "Turns Fleets",
        "Something went wrong.",
        snackPosition: SnackPosition.TOP,
      );
      Get.back();
    });
  }

  void logout(BuildContext context, MapsWithRoutesControllers controllers) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Center(
                child: Container(
                    height: 300,
                    width: Get.width * .8,
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        Container(
                          height: 96,
                          width: 96,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(50)),
                          child: Image.asset(
                            ImagesPaths.icLogout2,
                          ),
                        ),
                        "Logout"
                            .text
                            .size(18)
                            .fontWeight(FontWeight.w600)
                            .make()
                            .pOnly(top: 38, bottom: 20),
                        "Are you sure"
                            .text
                            .color(Colors.black)
                            .size(12)
                            .fontWeight(FontWeight.w500)
                            .make()
                            .py(5),
                        "You want to log out?"
                            .text
                            .color(Colors.black)
                            .size(12)
                            .fontWeight(FontWeight.w500)
                            .make()
                            .py(5)
                      ],
                    )),
              ).pOnly(top: 56),
              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          onTapNoOnLogout();
                        },
                        child: Container(
                          height: Get.height * .060,
                          width: Get.width * .28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.darkGray,
                              borderRadius: BorderRadius.circular(10)),
                          // padding: const EdgeInsets.all(2),
                          child: "No"
                              .text
                              .size(14)
                              .fontWeight(FontWeight.w600)
                              .color(AppColors.black)
                              .make(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onTapYesOnLogout();
                        },
                        child: Container(
                          height: Get.height * .060,
                          width: Get.width * .28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(10)),
                          // padding: const EdgeInsets.all(2),
                          child: "Yes"
                              .text
                              .size(14)
                              .fontWeight(FontWeight.w600)
                              .color(AppColors.white)
                              .make(),
                        ),
                      ),
                    ]).pOnly(left: 20, right: 20, bottom: 40)
              ],
            ));
    // child: const Text("Show alert Dialog box");
  }

  Future<void> getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      printData("LONG: ${position.longitude} ,LAT: ${position.latitude}");
      driverLat = position.latitude.toString();
      driverLong = position.longitude.toString();
    }).catchError((e) {
      printData(e.toString());
    });
  }

  void onTapStopItem({required String stopID, required String status}) {
    if (routeType.value == "today") {
      showLoader(Get.context);
      getCurrentPosition().then((value) {
        var request = {
          "stop_id": stopID,
          "driver_lat": driverLat,
          "driver_long": driverLong
        };

        this.stopID = stopID;
        this.status = status;
        stopDetailsAPI(request);
      });
    } else {
      showRouteNotStartedWarning();
    }
  }

  ///====function deliveryComplete bottom sheet =====///
  void stopDetailBottomSheet({
    required String routeName,
    required String distance,
    required String notes,
    required String status,
    required String lat,
    required String long,
    required String timing,
    required String customerAddress,
    required String outOfStops,
    required String userName,
    required String userPhone,
    required String bags,
    required String weight,
    required String stopID,
    required String pieces,
  }) {
    showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.93,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        routeName.text.semiBold
                            .size(12)
                            .color(AppColors.textGrey)
                            .fontWeight(FontWeight.w600)
                            .make(),
                        Container(
                          width: 40,
                          height: 40,
                          color: AppColors.white,
                          child: SizedBox(
                              height: 12,
                              width: 12,
                              child: Image.asset(ImagesPaths.icCross)),
                        ).onTap(() {
                          Get.back();
                        })
                      ],
                    ).pLTRB(24, 0, 24, 0),
                    Row(
                      children: [
                        "$outOfStops stops "
                            .text
                            .semiBold
                            .size(12)
                            .fontWeight(FontWeight.w600)
                            .color(AppColors.textGrey)
                            .make(),
                        Icon(
                          Icons.circle,
                          size: 5,
                          color: (AppColors.textGrey),
                        ).px(11),
                        distance.text.semiBold
                            .size(12)
                            .fontWeight(FontWeight.w600)
                            .color(AppColors.textGrey)
                            .make(),
                        Icon(
                          Icons.circle,
                          size: 5,
                          color: (AppColors.textGrey),
                        ).px(11),
                        timing.text.semiBold
                            .size(12)
                            .fontWeight(FontWeight.w600)
                            .color(AppColors.textGrey)
                            .make(),
                      ],
                    ).pLTRB(24, 6, 24, 9),
                    customerAddress.text.semiBold
                        .size(16)
                        .fontWeight(FontWeight.w700)
                        .make()
                        .pLTRB(24, 0, 0, 0),
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                          color: status == "Delivery"
                              ? AppColors.delivery
                              : AppColors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: status.text.semiBold
                          .size(10)
                          .fontWeight(FontWeight.w500)
                          .color(AppColors.white)
                          .make()
                          .centered()
                          .pOnly(bottom: 1),
                    ).pLTRB(24, 7, 0, 7),
                    Divider(
                      thickness: 1,
                      color: AppColors.lineGrey,
                      indent: 24,
                      endIndent: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userName.text.semiBold
                                .size(14)
                                .fontWeight(FontWeight.w600)
                                .make(),
                            userPhone.text.semiBold
                                .size(12)
                                .fontWeight(FontWeight.w600)
                                .make(),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                    height: 40,
                                    width: 48,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightGray,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.lineGrey)),
                                    child: Image.asset(ImagesPaths.icPhone))
                                .onTap(() {
                              makePhoneCall(userPhone);
                            }),
                            GestureDetector(
                              onTap: () {
                                messageBottomSheet(userPhone);
                              },
                              child: Container(
                                      height: 40,
                                      width: 48,
                                      decoration: BoxDecoration(
                                          color: AppColors.lightGray,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.lineGrey)),
                                      child:
                                          Image.asset(ImagesPaths.icMessage1))
                                  .pLTRB(24, 0, 0, 0),
                            ),
                          ],
                        ),
                      ],
                    ).pLTRB(24, 8, 32, 8),
                    Divider(
                      thickness: 1,
                      color: AppColors.lineGrey,
                      indent: 24,
                      endIndent: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: Get.width * 0.38,
                          decoration: BoxDecoration(
                              color: AppColors.lightGray,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: AppColors.lineGrey)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(ImagesPaths.icNavigation),
                              "Navigate"
                                  .text
                                  .semiBold
                                  .size(12)
                                  .fontWeight(FontWeight.w600)
                                  .make(),
                            ],
                          ).pLTRB(16, 0, 43, 0),
                        ).onTap(() {
                          launchGoogleMap(lat, long);
                        }),
                        Obx(
                          () => Container(
                            alignment: Alignment.center,
                            height: 48,
                            width: Get.width * 0.38,
                            decoration: BoxDecoration(
                                color: hasBeenCancelled.value == false
                                    ? AppColors.lightGray
                                    : AppColors.failed,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: hasBeenCancelled.value == false
                                        ? AppColors.lineGrey
                                        : AppColors.failed)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  ImagesPaths.icFailed,
                                  color: hasBeenCancelled.value == false
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
                                (hasBeenCancelled.value == true
                                        ? "Cancelled"
                                        : "Cancel")
                                    .text
                                    .semiBold
                                    .color(hasBeenCancelled.value == false
                                        ? AppColors.black
                                        : AppColors.white)
                                    .size(12)
                                    .fontWeight(FontWeight.w600)
                                    .make(),
                              ],
                            ).pLTRB(16, 0, 43, 0),
                          ).onTap(() {
                            // if route is currently working then hit api otherwise empty function
                            routeType.value == "today"
                                ? completeOrFail(
                                    type: "failed",
                                    method: "in",
                                    stopID: stopID)
                                : {
                                    printData(
                                        "Data can't be cancelled for Upcoming Routes")
                                  };
                          }),
                        ),
                        // Obx(() => GestureDetector(
                        //     onTap: () {
                        //       routeType.value == "today"
                        //           ? completeOrFail(
                        //               type: "failed",
                        //               method: "in",
                        //               stopID: stopID)
                        //           : {};
                        //     },
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       height: 48,
                        //       width: Get.width * 0.38,
                        //       decoration: BoxDecoration(
                        //           color: failed.value
                        //               ? AppColors.lightGray
                        //               : AppColors.failed,
                        //           borderRadius: BorderRadius.circular(10),
                        //           border: Border.all(
                        //               width: 1,
                        //               color: failed.value
                        //                   ? AppColors.lineGrey
                        //                   : AppColors.failed)),
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Image.asset(
                        //             ImagesPaths.icFailed,
                        //             color: failed.value
                        //                 ? AppColors.black
                        //                 : AppColors.white,
                        //           ),
                        //           (failed.value == true
                        //                   ? "Cancelled"
                        //                   : "Failed")
                        //               .text
                        //               .semiBold
                        //               .size(12)
                        //               .color(failed.value
                        //                   ? AppColors.black
                        //                   : AppColors.white)
                        //               .fontWeight(FontWeight.w600)
                        //               .make(),
                        //         ],
                        //       ).pLTRB(16, 0, 43, 0),
                        //     ))),
                      ],
                    ).pLTRB(24, 8, 24, 0),
                    GestureDetector(
                      onTap: () {
                        showNotes(notes, stopID);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: Get.width * .85,
                          decoration: BoxDecoration(
                              color: AppColors.lightGray,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: AppColors.lineGrey)),
                          child: Row(
                            children: [
                              Image.asset(
                                ImagesPaths.icNoPlasticBags,
                                height: 22,
                                width: 22,
                              ).pLTRB(17.83, 0, 19.83, 0),
                              Obx(() => stopNote.value.text.semiBold
                                  .size(12)
                                  .fontWeight(FontWeight.w600)
                                  .make())
                            ],
                          )).centered().pLTRB(24, 14, 24, 8),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.lineGrey,
                      indent: 24,
                      endIndent: 24,
                    ),
                    "View Detail"
                        .text
                        .semiBold
                        .size(12)
                        .fontWeight(FontWeight.w500)
                        .color(AppColors.textGrey)
                        .make()
                        .pLTRB(24, 10, 0, 10),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          deliveryDetailsItems(
                              title: "Bags",
                              description: "No. of Bags",
                              imageAssets: ImagesPaths.icBag2,
                              quantity: bags),
                          deliveryDetailsItems(
                              title: "Weight",
                              description: "lbs",
                              imageAssets: ImagesPaths.icWeight,
                              quantity: weight),
                          deliveryDetailsItems(
                              title: "Pieces",
                              description: "No. of Items",
                              imageAssets: ImagesPaths.icPieces,
                              quantity: pieces),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.lineGrey,
                      indent: 24,
                      endIndent: 24,
                    ),
                    Obx(
                      () => Container(
                              alignment: Alignment.center,
                              height: 48,
                              width: Get.width * 0.85,
                              decoration: BoxDecoration(
                                color: hasBeenCancelled.value == true
                                    ? AppColors.lineGrey
                                    : status == "Delivery"
                                        ? AppColors.delivery
                                        : AppColors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: "$status Complete"
                                  .text
                                  .semiBold
                                  .size(12)
                                  .color(hasBeenCancelled.value == true
                                      ? AppColors.black
                                      : AppColors.white)
                                  .fontWeight(FontWeight.w600)
                                  .make())
                          .onTap(() {
                            hasBeenCancelled.value == true
                                ? {}
                                : routeType.value == "today"
                                    ? completeOrFail(
                                        type: "completed",
                                        method: "in",
                                        stopID: stopID)
                                    : {};
                            // completeOrFail(
                            //     type: "completed", method: "in", stopID: stopID);
                          })
                          .py(14)
                          .centered(),
                    )
                  ],
                ).pLTRB(0, 27, 0, 0),
              ),
            ).pLTRB(8, 8, 8, 0));
  }

  ///==== function message bottom sheet =====///
  void messageBottomSheet(String phoneNumber) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: Get.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              ImagesPaths.icMessage,
                              width: 19,
                              height: 19.6,
                            ).marginOnly(right: 14.69),
                            "Messages"
                                .text
                                .fontWeight(FontWeight.w600)
                                .size(16)
                                .make(),
                          ],
                        ),
                        Container(
                                width: 40,
                                height: 40,
                                color: AppColors.white,
                                child: Image.asset(
                                  ImagesPaths.icCross,
                                  height: 14,
                                  width: 14,
                                ).pOnly(bottom: 5))
                            .onTap(() {
                          Get.back();
                        })
                      ],
                    ).pLTRB(8, 29, 13, 16),
                    SizedBox(
                      height: 64.0 * (titles.length),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: titles.length,
                        itemBuilder: (context, position) {
                          return showMessagesBottomSheet(
                            index: position,
                            value: message,
                          );
                        },
                      ),
                    ),
                  ],
                ).px(16),
              ).expand(),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.boxFill,
                        border: Border.all(color: AppColors.lineGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                          height: 48,
                          width: Get.width * 0.55,
                          child: TextField(
                            controller: messageController,
                            onChanged: (message) {
                              messageToBeSent = message;
                              selectedIndex.value = -1;
                            },
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ).pOnly(left: 5)),
                    ),
                    Container(
                      height: 48,
                      width: Get.width * .28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(2),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ).onTap(() {
                      sendMessage(phone: phoneNumber);
                    })
                  ],
                ).pOnly(
                  bottom: 20,
                ),
              ).px(10)
            ],
          )).px(8),
    );
  }

  Widget deliveryDetailsItems({
    required String title,
    required String description,
    required String imageAssets,
    required String quantity,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        height: 72,
        width: Get.width * 0.85,
        decoration: BoxDecoration(
            color: AppColors.boxFill,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: AppColors.black),
              child: Image.asset(
                imageAssets,
                color: AppColors.white,
                height: 24,
                width: 24,
              ),
            ),
            SizedBox(
              width: (Get.width * .80) - 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      title.text.semiBold
                          .size(16)
                          .fontWeight(FontWeight.w600)
                          .make(),
                      description.text.semiBold
                          .size(12)
                          .fontWeight(FontWeight.w500)
                          .make()
                    ],
                  ),
                  quantity.text.semiBold
                      .size(30)
                      .fontWeight(FontWeight.w600)
                      .make()
                      .marginOnly(right: 10),
                ],
              ),
            )
          ],
        ),
      ).pLTRB(24, 0, 24, 0),
    );
  }

  ///====Widget some message Box =====///
  Widget showMessagesBottomSheet({required int index, required RxBool value}) {
    return Container(
      height: 64,
      width: Get.width * 0.86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          const BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titles[index]
              .text
              .fontWeight(FontWeight.w600)
              .size(14)
              .overflow(TextOverflow.ellipsis)
              .make()
              .centered()
              .px(8),
          Container(
            alignment: Alignment.center,
            height: 17,
            width: 17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
            child: Obx(() => Visibility(
                visible: selectedIndex.value == index ? true : false,
                child: Icon(
                  Icons.done,
                  color: AppColors.checkbox,
                  size: 14,
                ))),
          ).marginOnly(right: 15),
        ],
      ),
    ).py(8).onTap(() {
      selectMessage(index);
    });
  }

  void addNotesAPI(String stopID) {
    Get.back();
    var request = {"stop_id": stopID, "notes": notesController.text};
    CallAPI().addStopNote(request).then((value) {
      // Get.back();

      if (value.status == true) {
        stopNote.value = notesController.text;
        // getCurrentPosition().then((value) {
        //   var request = {
        //     "stop_id": stopID,
        //     "driver_lat": driverLat,
        //     "driver_long": driverLong
        //   };

        // stopDetailsAPI(request);
        getStopLists(ApiFrom.out);
        // });

        Get.snackbar(
          "Turns Fleets",
          value.message ?? "Notes added successfully",
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          "Turns Fleets",
          value.message ?? "Something went wrong",
          snackPosition: SnackPosition.TOP,
        );
      }
    }).onError((error, stackTrace) {
      Get.back();
    });
  }

  void startRouteAlert() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (ctx) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0)),
            child: SizedBox(
              height: 230,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2)),
                      child: Image.asset(
                        ImagesPaths.icWarning,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    "Stop not started yet !"
                        .text
                        .fontWeight(FontWeight.w600)
                        .make()
                        .py(20),
                    Container(
                      height: 40,
                      width: Get.width * .6,
                      decoration: BoxDecoration(
                          color: Colors.green.shade800,
                          borderRadius: BorderRadius.circular(7)),
                      child: "Ok".text.color(Colors.white).make().centered(),
                    ).onTap(() {
                      Get.back();
                    }),
                  ]),
            )));
  }

  void undoPickupOrDelivery(String stopId) {
    showLoader(Get.context);
    var request = {"stop_id": stopId, "type": "undo"};
    CallAPI().updateStopStatus(request).then((value) {
      if (value.status == true) {
        Get.snackbar(
          "Turns Fleets",
          value.message ?? "Something went wrong",
          snackPosition: SnackPosition.TOP,
        );
        getStopLists(ApiFrom.undo);
      } else {
        Get.snackbar(
          "Turns Fleets",
          value.message ?? "Something went wrong",
          snackPosition: SnackPosition.TOP,
        );
      }
    }).onError((error, stackTrace) {
      printData("$error $stackTrace");
    }).whenComplete(() {
      Get.closeAllSnackbars();
    });
  }
}

enum ApiFrom { undo, none, out }
