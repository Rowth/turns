import 'package:driver/services/networking_services/api_call.dart';
import 'package:driver/services/response_models/get_store_response_model.dart';
import 'package:driver/services/response_models/routes_list_response_model.dart';
import 'package:driver/utils/localization/loader_dialog.dart';
import 'package:driver/utils/routes/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localization/SharedPrefKeys.dart';
import '../utils/localization/app_colors.dart';
import '../utils/localization/images_paths.dart';
import '../utils/localization/print_data.dart';

class HomeController extends SuperController {
  final GlobalKey<ScaffoldState> keys = GlobalKey();
  RxBool hasRoutes = false.obs;
  bool isLoading = true;
  String updateListKey = "37654ae4c9a570b96c615c24055d5e50";
  RxString userName = "".obs;
  RxString userPhone = "".obs;
  List<StoreResponseData> getStores = [];
  List<RouteListData> upcomingRoutes = [];
  List<RouteListData> todayRoutes = [];
  RxString selectedStore = "".obs;
  String routeID = "";
  String routeType = "";
  RouteStatus? routeStatus;

  void onTapRouteItemWidget(
      {required String routeId, required RouteStatus status}) {
    routeStatus = status;
    routeID = routeId;
    Get.toNamed(MyRoutes.mapsWihRouteUI);
  }

  void getUserData() {
    GetStorage storage = GetStorage();
    userName.value =
        storage.read(SharedPrefrencesKeys.USER_NAME) ?? "Driver Name";
    userPhone.value =
        storage.read(SharedPrefrencesKeys.USER_PHONE) ?? "Driver Phone";
  }

  String formatTime(String time) {
    return DateFormat.jm()
        .format(DateFormat('HH:mm').parse(time))
        .toUpperCase();
  }

  @override
  Future<void> onInit() async {
    // USER Data from Shared Pref
    Future.delayed(const Duration(microseconds: 1)).then((value) {
      showLoader(Get.context);
    });
    getUserData();
    await getStoreList();

    super.onInit();
  }

  showDropDownMenu(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Container(
        height: Get.height * .8,
        width: Get.width * .85,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Stores"
                    .text
                    .size(16)
                    .fontWeight(FontWeight.w700)
                    .make()
                    .pLTRB(0, 0, 0, 11),
                const Icon(
                  Icons.close,
                  size: 18,
                ).onTap(() {
                  Get.back();
                }),
              ],
            ),
            Divider(
              thickness: 1,
              color: AppColors.black,
              indent: 2,
              endIndent: 2,
            ),
            SizedBox(
              height: Get.height * 0.72,
              child: ListView.builder(
                itemCount: getStores.length,
                itemBuilder: (context, position) {
                  return Container(
                    width: Get.width * .85,
                    height: 70,
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getStores[position]
                            .storeName!
                            .text
                            .size(14)
                            .fontWeight(FontWeight.w600)
                            .make()
                            .pLTRB(48, 15, 0, 15),
                        Divider(
                          thickness: 1,
                          color: AppColors.darkGray,
                          indent: 5,
                          endIndent: 5,
                        )
                      ],
                    ),
                  ).onTap(() {
                    selectStore(position);
                  });
                },
              ),
            ).pLTRB(0, 5, 0, 5),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  void logout(BuildContext context) {
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
              actions: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
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
                          // Get.offAllNamed(MyRoutes.driverIdUI);
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

  Future<void> getStoreList() async {
    CallAPI().getStoresList().then((value) {
      if (value.status == true) {
        getStores = value.data!;
        selectedStore.value = getStores[0].storeName!;
        if (getStores.isNotEmpty) {
          getRoutesData("${getStores[0].id}");
        }
        printData(getStores[0].storeName!);
      } else {
        if (value.message == "Token has expired") {
          CallAPI().getUpdatedToken().then((value) {
            if (value.status == true) {
              GetStorage storage = GetStorage();
              storage
                  .write(SharedPrefrencesKeys.ACCESS_TOKEN_KEY,
                      value.data?.accessToken)
                  .then((value) {
                getStoreList();
              });
            }
          });
        } else {
          Get.back();
          Get.snackbar(
            "Turns Fleet",
            value.message,
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    }).onError((error, stackTrace) {
      Get.back();
      printData("$error");
    });
  }

  void selectStore(int position) {
    selectedStore.value = getStores[position].storeName!;
    getRoutesData("${getStores[position].id}");
    Get.back();
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

  void getRoutesData(String storeId) {
    var request = {"store_id": storeId};
    CallAPI().getDriverRouteList(request).then((value) {
      todayRoutes.clear();
      upcomingRoutes.clear();
      if (value.status == true) {
        hasRoutes.value = true;

        for (int i = 0; i <= value.data.length - 1; i++) {
          if (value.data[i].currentRoute == "0") {
            todayRoutes.add(value.data[i]);
          } else {
            upcomingRoutes.add(value.data[i]);
            // upComingRouteDate.value = formatDate(value.data[i].routeDate!);
          }
        }
        isLoading = false;
        update([updateListKey]);
        Get.back();
      } else {
        if (value.message == "Token has expired") {
          CallAPI().getUpdatedToken().then((value) {
            if (value.status == true) {
              GetStorage storage = GetStorage();
              storage
                  .write(SharedPrefrencesKeys.ACCESS_TOKEN_KEY,
                      value.data?.accessToken)
                  .then((value) {
                getStoreList();
              }).onError((error, stackTrace) {
                Get.snackbar(
                  "Turns Fleet",
                  "Something went wrong",
                  snackPosition: SnackPosition.TOP,
                );
              });
            }
          });
        } else {
          Get.back();
          hasRoutes.value = false;
          Get.snackbar(
            "Turns Fleet",
            value.message ?? "Something went wrong",
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    });
  }

  // String formatDate(String date) {
  //   printData(("INPUT Date: $date"));
  //   printData(DateFormat('EEE DD MMM')
  //       .format(DateFormat('yyyy-MM-dd').parse(date))
  //       .toString());
  //   return DateFormat('EEE DD MMM')
  //       .format(DateFormat('yyyy-MM-dd').parse(date))
  //       .toString();
  // }

  // String formatDate(String date) {
  //   String finalDate = Jiffy(date).MMMEd.toString(); // Mar 2nd 21
  //
  //   finalDate = finalDate.replaceAll(",", "");
  //   return finalDate;
  // }

  @override
  void onDetached() {
    printData("onDetached");
  }

  @override
  void onInactive() {
    printData("onInactive");
  }

  @override
  void onPaused() {
    printData("onPaused");
  }

  @override
  void onResumed() {
    printData("Resumed");
  }
}

enum RouteStatus { running, notStarted, completed }
