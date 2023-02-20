import 'package:driver/icons.dart';
import 'package:driver/utils/localization/app_colors.dart';
import 'package:driver/utils/localization/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/maps_with_route_controllers.dart';
import '../../utils/localization/print_data.dart';
import '../../utils/routes/my_routes.dart';

class MapsWihRouteUI extends StatefulWidget {
  const MapsWihRouteUI({Key? key}) : super(key: key);

  @override
  State<MapsWihRouteUI> createState() => _MapsWihRouteUIState();
}

class _MapsWihRouteUIState extends State<MapsWihRouteUI> {
  @override
  Widget build(BuildContext context) {
    MapsWithRoutesControllers controllers = Get.find();
    return WillPopScope(
      onWillPop: controllers.getBackToHome,
      child: Scaffold(
        key: controllers.keys,
        backgroundColor: AppColors.lightGray,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.white,
          leadingWidth: 70,
          leading: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.passthrough,
                  children: [
                InkWell(
                  onTap: () {
                    controllers.keys.currentState!.openDrawer();
                  },
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(52),
                      color: Colors.green,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network("", fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                          return Center(
                              child: (controllers.userName[0])
                                  .text
                                  .white
                                  .size(20)
                                  .semiBold
                                  .make());
                        })),
                  ).centered().pLTRB(0, 0, 0, 0),
                ),
                Visibility(
                  visible: true,
                  child: Positioned(
                    bottom: 8,
                    left: 37,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.menu,
                            color: AppColors.black,
                            size: 16,
                          )),
                    ).onTap(() {
                      controllers.keys.currentState!.openDrawer();
                    }),
                  ),
                )
              ])
              .tooltip(MaterialLocalizations.of(context).openAppDrawerTooltip),
          title: controllers.title.text
              .size(16)
              .color(AppColors.black)
              .fontWeight(FontWeight.w600)
              .make()
              .pLTRB(10, 0, 0, 0),
          actions: [
            Image.asset(ImagesPaths.icNotifications, height: 16, width: 20)
                .pLTRB(0, 0, 20, 0),
          ],
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6, //<-- SEE HERE
          child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const  SizedBox(height: 40,),
                    Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(112),
                          color: Colors.green,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(110),
                            child: Image.network("", fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception,
                                    StackTrace? stackTrace) {
                              return Center(
                                  child: (controllers.userName[0])
                                      .text
                                      .white
                                      .size(40)
                                      .semiBold
                                      .make());
                            }))).pLTRB(0, 32, 0, 29),
                    controllers.userName.text
                        .size(20)
                        .fontWeight(FontWeight.w700)
                        .make(),
                    controllers.userPhone.text
                        .size(14)
                        .fontWeight(FontWeight.w600)
                        .make()
                        .pLTRB(0, 2, 0, 0),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ).pLTRB(10, 0, 0, 0),
              Divider(
                thickness: 1,
                color: AppColors.black,
                endIndent: 24,
                indent: 24,
              ).pLTRB(0, 7, 0, 10),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      ImagesPaths.icDashboard,
                      height: 22,
                      width: 22,
                    ).pLTRB(5, 0, 20.75, 0),
                    "Dashboard"
                        .text
                        .size(14)
                        .fontWeight(FontWeight.w600)
                        .make(),
                  ],
                ),
                onTap: () {
                  Get.offAllNamed(MyRoutes.homePageUI);
                },
              ),
              Divider(
                thickness: 1,
                color: AppColors.drawerDivider,
                indent: 24,
                endIndent: 56,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImagesPaths.icPastRoutes,
                      height: 22,
                      width: 22,
                    ).pLTRB(5, 0, 20.75, 0),
                    "Past Routes"
                        .text
                        .size(14)
                        .fontWeight(FontWeight.w600)
                        .make(),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                thickness: 1,
                color: AppColors.drawerDivider,
                indent: 24,
                endIndent: 56,
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      ImagesPaths.icLockPrivacy,
                      height: 22,
                      width: 22,
                    ).pLTRB(5, 0, 20.75, 0),
                    "Privacy Policy"
                        .text
                        .size(14)
                        .fontWeight(FontWeight.w600)
                        .make(),
                  ],
                ),
                onTap: () {
                  controllers.launchInBrowser(Uri(
                      scheme: 'https',
                      host: 'www.turnsapp.com',
                      path: '/privacy-policy/'));
                },
              ),
              Divider(
                thickness: 1,
                color: AppColors.drawerDivider,
                indent: 24,
                endIndent: 56,
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      ImagesPaths.icDocument,
                      height: 22,
                      width: 22,
                    ).pLTRB(5, 0, 20.75, 0),
                    "Terms of Service"
                        .text
                        .size(14)
                        .fontWeight(FontWeight.w600)
                        .make(),
                  ],
                ),
                onTap: () {
                  controllers.launchInBrowser(Uri(
                      scheme: 'https',
                      host: 'www.turnsapp.com',
                      path: '/terms-of-service/'));
                },
              ),
              Divider(
                thickness: 1,
                color: AppColors.black,
                indent: 24,
                endIndent: 24,
              ).pLTRB(0, 90, 0, 28),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      ImagesPaths.icLogout,
                      height: 22,
                      width: 22,
                    ).pLTRB(5, 0, 20.75, 0),
                    "Log out"
                        .text
                        .size(14)
                        .fontWeight(FontWeight.w600)
                        .make(),
                  ],
                ).pLTRB(0, 0, 0, 58),
                onTap: () {
                  controllers.logout(context, controllers);
                  // Navigator.pop(context);
                },
              ),
            ]),
          ),
        ),
        body: SnappingSheet(
            controller: controllers.sheetController,
            lockOverflowDrag: false,
            snappingPositions: const [
              SnappingPosition.factor(
                positionFactor: 0.0,
                snappingCurve: Curves.easeOut,
                snappingDuration: Duration(milliseconds: 500),
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
              SnappingPosition.factor(
                positionFactor: 0.5,
                snappingCurve: Curves.easeOut,
                snappingDuration: Duration(milliseconds: 500),
              ),
              SnappingPosition.factor(
                grabbingContentOffset: GrabbingContentOffset.bottom,
                snappingCurve: Curves.easeOut,
                snappingDuration: Duration(milliseconds: 500),
                positionFactor: 0.9,
              ),
            ],
            grabbing: grabbingWidget(context, controllers),
            grabbingHeight: 50,
            sheetAbove: null,
            sheetBelow: SnappingSheetContent(
                draggable: () => true,
                childScrollController: controllers.listViewController,
                child: Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.lineGrey,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "Find stops",
                            hintStyle: TextStyle(
                                color: AppColors.findStop,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors.black,
                            ),
                          ),
                        ).marginOnly(left: 20, right: 8),
                      ).px(24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => controllers.routeName.value.text
                              .size(24)
                              .fontWeight(FontWeight.w600)
                              .make()),
                          Obx(() => controllers.isRouteStarted.value
                              ? "Running"
                                  .text
                                  .size(12)
                                  .fontWeight(FontWeight.w600)
                                  .color(AppColors.running)
                                  .make()
                              : "Start your Route"
                                  .text
                                  .size(12)
                                  .fontWeight(FontWeight.w600)
                                  .color(AppColors.red)
                                  .make()),
                        ],
                      ).pLTRB(24, 15, 24, 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => controllers.timings.value.text
                              .size(12)
                              .fontWeight(FontWeight.w600)
                              .color(AppColors.textGrey)
                              .make()),
                          Icon(
                            Icons.circle,
                            color: AppColors.textGrey,
                            size: 5,
                          ).px(11),
                          Obx(() => ("${controllers.totalStops.value} Stops")
                              .text
                              .size(12)
                              .fontWeight(FontWeight.w600)
                              .color(AppColors.textGrey)
                              .make()),
                          Icon(
                            Icons.circle,
                            color: AppColors.textGrey,
                            size: 5,
                          ).px(11),
                          Obx(() => (controllers.totalDistance.value)
                              .text
                              .size(12)
                              .color(AppColors.textGrey)
                              .fontWeight(FontWeight.w600)
                              .make()),
                        ],
                      ).pLTRB(24, 9, 10, 0),
                      Container(
                        width: Get.width * .9,
                        height: 1,
                        color: AppColors.darkGray,
                      ).px(24).marginOnly(bottom: 22, top: 19),
                      SingleChildScrollView(
                        controller: controllers.listViewController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            GetBuilder<MapsWithRoutesControllers>(
                                id: controllers.updateListKey,
                                builder: (value) {
                                  return SizedBox(
                                      height: 135 *
                                          (controllers.driverStopsList.length
                                              .toDouble()),
                                      child: SlidableAutoCloseBehavior(
                                        closeWhenTapped: true,
                                        closeWhenOpened: true,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: controllers
                                                .driverStopsList.length,
                                            itemBuilder: (BuildContext context,
                                                int position) {
                                              return slidablePanelWidget(
                                                  context,
                                                  position,
                                                  controllers);
                                            }),
                                      ));
                                }),
                          ],
                        ),
                      ).px(15).expand(),
                      Divider(
                        thickness: 1,
                        color: AppColors.darkGray,
                        endIndent: 32,
                        indent: 32,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            controllers.isRouteStarted.value == false
                                ? controllers.clickStartRoute(
                                    type: controllers.routeType.value)
                                : {
                                    controllers.allStopsCompleted.value == true
                                        ? controllers.clickCompleteRoute(
                                            type: controllers.routeType.value)
                                        : Get.snackbar(
                                            "Turns Fleets",
                                            "Complete your all stops first",
                                            snackPosition: SnackPosition.TOP,
                                          )
                                  };
                          },
                          child: Container(
                            height: 48,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: controllers.isRouteStarted.value
                                    ? controllers.allStopsCompleted.value ==
                                            true
                                        ? AppColors.red
                                        : AppColors.textGrey
                                    : controllers.routeType.value == "upcoming"
                                        ? AppColors.textGrey
                                        : AppColors.accent),
                            child: (controllers.isRouteStarted.value
                                    ? "Complete Route"
                                    : "Start Route")
                                .text
                                .size(14)
                                .color(AppColors.white)
                                .fontWeight(FontWeight.w600)
                                .make()
                                .centered(),
                          ).marginOnly(
                              left: 24, top: 15, bottom: 15, right: 24),
                        ),
                      )
                    ],
                  ).px(0),
                ).px(8)),
            child: googleMap(context, controllers)),
      ),
    );
  }
}

///====Widget package to snapping sheet   =====///
Widget grabbingWidget(
    BuildContext context, MapsWithRoutesControllers mapsWithRoutesControllers) {
  return Container(
    height: 60,
    alignment: Alignment.center,
    width: Get.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      boxShadow: [
        BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
      ],
    ),
    child: Container(
      width: 80,
      height: 7,
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(7),
      ),
    ),
  ).px(8);
}

///====Widget package google maps  =====///
Widget googleMap(BuildContext context, MapsWithRoutesControllers controllers) {
  return GoogleMap(
    compassEnabled: false,
    myLocationButtonEnabled: false,
    zoomControlsEnabled: false,
    buildingsEnabled: true,
    cameraTargetBounds: CameraTargetBounds.unbounded,
    mapType: MapType.normal,
    initialCameraPosition: controllers.initialCam,
    onMapCreated: (GoogleMapController googleMapController) {
      controllers.handleLocationPermission().then((value) {
        if (value) {
          controllers.getCurrentLocation(googleMapController);
        } else {
          controllers.handleLocationPermission();
        }
      });
    },
  );
}

///====Widget package Slidable Action using for routes=====///
Widget slidablePanelWidget(
    BuildContext context, int index, MapsWithRoutesControllers controllers) {
  return Slidable(
    enabled: controllers.routeType.value == "today",
    closeOnScroll: true,
    startActionPane: ActionPane(
      motion: const DrawerMotion(),
      dragDismissible: true,
      children: [
        SlidableAction(
          onPressed: ((context) {
            controllers.launchGoogleMap(
                "${controllers.driverStopsList[index].userLat}",
                "${controllers.driverStopsList[index].userLng}");
          }),
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          icon: MyFlutterApp.navigate,
          label: 'Navigate',
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        controllers.driverStopsList[index].stopStatus == "1"
            ? SlidableAction(
                autoClose: true,
                flex: 1,
                onPressed: ((context) {
                  controllers.undoPickupOrDelivery(
                      "${controllers.driverStopsList[index].stopId}");
                }),
                backgroundColor: AppColors.lineGrey,
                foregroundColor: Colors.black,
                icon: MyFlutterApp.undo,
                label: "Undo",
              )
            : SlidableAction(
                flex: 1,
                autoClose: true,
                onPressed: ((context) {
                  controllers.isRouteStarted.value == true
                      ? controllers.routeType.value == "today"
                          ? controllers.completeOrFail(
                              stopID:
                                  "${controllers.driverStopsList[index].stopId}",
                              type: "completed",
                              method: "swipe")
                          : {}
                      : controllers.showRouteNotStartedWarning();
                }),
                backgroundColor:
                    controllers.driverStopsList[index].status == "Pickup"
                        ? AppColors.blue
                        : AppColors.delivery,
                foregroundColor: Colors.white,
                icon:MyFlutterApp.truck,
                label: controllers.driverStopsList[index].status,
              )
      ],
    ),
    child: stopsItemWidget(index, controllers),
  );
}

Widget stopsItemWidget(int index, MapsWithRoutesControllers controllers) {
  return GestureDetector(
    onTap: () {
      controllers.driverStopsList[index].stopStatus == "0"
          ? controllers.onTapStopItem(
              stopID: "${controllers.driverStopsList[index].stopId}",
              status: "${controllers.driverStopsList[index].status}")
          : {printData("stop completed")};
    },
    child: Container(
      width: Get.width * .9,
      alignment: Alignment.topCenter,
      child: Row(children: [
        Column(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: controllers.driverStopsList[index].stopStatus == "1"
                      ? AppColors.lineGrey
                      : AppColors.black,
                  width: 1,
                ),
              ),
              child: "${index + 1}"
                  .text
                  .size(16)
                  .color(
                    controllers.driverStopsList[index].stopStatus == "1"
                        ? AppColors.lineGrey
                        : AppColors.black,
                  )
                  .fontWeight(FontWeight.w600)
                  .make()
                  .centered(),
            ),
            (controllers.driverStopsList.length) - 1 != index
                ? controllers.driverStopsList[index].stopStatus == "1"
                    ? Column(
                        children: [
                          Container(
                            height: 50,
                            width: 1,
                            color: AppColors.lineGrey,
                          ),
                          Icon(
                            Icons.circle,
                            color: AppColors.lineGrey,
                            size: 11,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: AppColors.lineGrey,
                          ),
                        ],
                      )
                    : Container(
                        height: 98,
                        width: 1,
                        color: AppColors.black,
                      )
                : Column(
                    children: [
                      Container(
                        height: 50,
                        width: 1,
                        color: AppColors.white,
                      ),
                      const Icon(
                        Icons.circle,
                        size: 11,
                        color: AppColors.white,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: AppColors.white,
                      ),
                    ],
                  ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${controllers.driverStopsList[index].stop}"
                .text
                .size(14)
                .overflow(TextOverflow.ellipsis)
                .color(controllers.driverStopsList[index].stopStatus == "1"
                    ? AppColors.lineGrey
                    : AppColors.black)
                .fontWeight(FontWeight.w600)
                .make()
                .w(Get.width * .6),
            Container(
              alignment: Alignment.center,
              width: Get.width * .7,
              height: 40,
              color: AppColors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: "# ${controllers.driverStopsList[index].invoiceNo}"
                        .text
                        .size(14)
                        .color(
                            controllers.driverStopsList[index].stopStatus == "1"
                                ? AppColors.lineGrey
                                : AppColors.black)
                        .fontWeight(FontWeight.w500)
                        .make(),
                  ),
                  SizedBox(
                    height: 25,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 15,
                          decoration: BoxDecoration(
                              color:
                                  controllers.driverStopsList[index].status ==
                                          "Delivery"
                                      ? AppColors.delivery
                                      : AppColors.blue,
                              borderRadius: BorderRadius.circular(3)),
                          child:
                              ("${controllers.driverStopsList[index].status}")
                                  .text
                                  .size(8)
                                  .fontWeight(FontWeight.w500)
                                  .color(AppColors.white)
                                  .make()
                                  .px(4)
                                  .centered()),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: controllers
                        .formatTime(
                            controllers.driverStopsList[index].estTime ?? "")
                        .text
                        .size(14)
                        .color(
                            controllers.driverStopsList[index].stopStatus == "1"
                                ? AppColors.lineGrey
                                : AppColors.black)
                        .fontWeight(FontWeight.w500)
                        .make(),
                  ),
                ],
              ),
            ),
            controllers.driverStopsList[index].stopNotes != ""
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 32,
                      width: Get.width * .70,
                      decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Image.asset(
                            ImagesPaths.icPlasticBag,
                            color:
                                controllers.driverStopsList[index].stopStatus ==
                                        "1"
                                    ? AppColors.lineGrey
                                    : AppColors.black,
                            height: 22,
                            width: 22,
                          ).marginOnly(left: 5),
                          SizedBox(
                              width: Get.width * .7 - 27,
                              child: Text(
                                "${controllers.driverStopsList[index].stopNotes}",
                                style: TextStyle(
                                    color: controllers.driverStopsList[index]
                                                .stopStatus ==
                                            "1"
                                        ? AppColors.lineGrey
                                        : AppColors.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).marginOnly(left: 3)),
                        ],
                      ),
                    ).pLTRB(0, 10, 0, 2),
                  )
                : const SizedBox()
          ],
        ).pLTRB(20, 0, 0, 26)
      ]),
    ).marginOnly(left: 10),
  );
}
