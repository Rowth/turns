import 'package:driver/controllers/home_controller.dart';
import 'package:driver/utils/localization/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localization/images_paths.dart';
import '../utils/localization/print_data.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Scaffold(
        key: controller.keys,
        backgroundColor: AppColors.lightGray,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.white,
          leadingWidth: 70,
          leading: SizedBox(
            width: 70,
            child: Stack(fit: StackFit.passthrough, children: [
              InkWell(
                onTap: () {
                  controller.keys.currentState!.openDrawer();
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
                      child: Image.network("", fit: BoxFit.cover, errorBuilder:
                          (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                        return Center(
                            child: Obx(() => (controller.userName.value[0])
                                .text
                                .white
                                .size(20)
                                .semiBold
                                .make()));
                      })),
                ),
              ).centered(),
              Positioned(
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
                  controller.keys.currentState!.openDrawer();
                }),
              )
            ]),
          ).tooltip(MaterialLocalizations.of(context).openAppDrawerTooltip),
          centerTitle: true,
          title: GestureDetector(
              onTap: () {
                controller.showDropDownMenu(context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.darkGray, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => controller.selectedStore.value.text
                        .size(14)
                        .color(AppColors.black)
                        .fontWeight(FontWeight.w600)
                        .make()),
                    Icon(Icons.expand_more_sharp, color: (AppColors.black))
                  ],
                ).marginOnly(left: 17, right: 20, top: 13, bottom: 14),
              ).marginOnly(left: 20, right: 10, top: 16, bottom: 16)),
          actions: [
            Image.asset(ImagesPaths.icNotifications, height: 20, width: 20)
                .marginOnly(right: 26)
          ],
        ),
        drawer: SizedBox(
          width: Get.width * 0.6,
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
                                  child: Obx(() =>
                                      (controller.userName.value[0])
                                          .text
                                          .white
                                          .size(40)
                                          .semiBold
                                          .make()));
                            }))).pLTRB(0, 32, 0, 29),
                    Obx(() => (controller.userName.value)
                        .text
                        .size(20)
                        .maxLines(2)
                        .fontWeight(FontWeight.w700)
                        .make()),
                    Obx(() => (controller.userPhone.value)
                        .text
                        .size(14)
                        .fontWeight(FontWeight.w600)
                        .make()
                        .pLTRB(0, 2, 0, 0)),
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
                  controller.launchInBrowser(Uri(
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
                  controller.launchInBrowser(Uri(
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
                  controller.logout(context);
                },
              ),
            ]),
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => hasRoutesIn(controller),
          ),
        ));
  }

  Widget hasRoutesIn(HomeController controller) {
    if (controller.hasRoutes.value == true) {
      return Column(
        children: [
          SizedBox(
                  width: Get.width,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: "Today's Route"
                            .text
                            .fontWeight(FontWeight.w700)
                            .size(16)
                            .make(),
                      ),
                      Expanded(
                          child: Divider(
                        color: AppColors.darkGray,
                      ).marginOnly(left: 5))
                    ],
                  ).pLTRB(0, 38, 0, 0))
              .px(20),
          GetBuilder<HomeController>(
            id: controller.updateListKey,
            builder: (value) {
              if (value.isLoading == true) {
                return const Center(child: SizedBox());
              } else {
                return Container(
                  alignment: Alignment.topCenter,
                  // color: Colors
                  //     .primaries[Random().nextInt(Colors.primaries.length)],
                  height: (controller.todayRoutes.isNotEmpty
                          ? controller.todayRoutes.length
                          : 1) *
                      290,
                  width: Get.width,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.todayRoutes.isEmpty
                          ? 1
                          : controller.todayRoutes.length,
                      itemBuilder: (BuildContext context, int position) {
                        return controller.todayRoutes.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                width: Get.width,
                                height: 100,
                                child: "No Today's Routes Available"
                                    .text
                                    .red500
                                    .make(),
                              )
                            : routesItemWidget(
                                controller: controller,
                                routeType: "today",
                                routeID:
                                    "${controller.todayRoutes[position].routeId}",
                                routeName:
                                    "${controller.todayRoutes[position].routeName}",
                                timing:
                                    "${controller.formatTime("${controller.todayRoutes[position].routeTimingFrom}")}-${controller.formatTime("${controller.todayRoutes[position].routeTimingTo}")}",
                                stops:
                                    "${controller.todayRoutes[position].totalStop}",
                                bag:
                                    "${controller.todayRoutes[position].totalBag}",
                                weight:
                                    "${controller.todayRoutes[position].totalWeights}",
                                pieces:
                                    "${controller.todayRoutes[position].totalPieces}",
                                routeStatus:
                                    "${controller.todayRoutes[position].routeStatus}",
                              );
                      }),
                );
              }
            },
          ),
          SizedBox(
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                "Upcoming Routes"
                    .text
                    .fontWeight(FontWeight.w700)
                    .size(16)
                    .make().marginOnly(top:15),
                Expanded(
                    child: Divider(
                  color: AppColors.darkGray,
                ).marginOnly(left: 5)),
              ],
            ).pLTRB(0, 0, 0, 0),
          ).px(22),
          GetBuilder<HomeController>(
            id: controller.updateListKey,
            builder: (value) {
              if (value.isLoading == true) {
                return const Center(child: SizedBox());
              } else {
                return SizedBox(
                  height: (controller.upcomingRoutes.isNotEmpty
                          ? controller.upcomingRoutes.length
                          : 1) *
                      290,
                  width: Get.width,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.upcomingRoutes.isEmpty
                          ? 1
                          : controller.upcomingRoutes.length,
                      itemBuilder: (BuildContext context, int position) {
                        return controller.upcomingRoutes.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                width: Get.width,
                                height: 100,
                                child: "No Upcoming Routes Available"
                                    .text
                                    .red500
                                    .make(),
                              )
                            : routesItemWidget(
                                controller: controller,
                                routeType: "upcoming",
                                routeID:
                                    "${controller.upcomingRoutes[position].routeId}",
                                routeName:
                                    "${controller.upcomingRoutes[position].routeName}",
                                timing:
                                    "${controller.upcomingRoutes[position].turnAroundTime}",
                                stops:
                                    "${controller.upcomingRoutes[position].totalStop}",
                                bag:
                                    "${controller.upcomingRoutes[position].totalBag}",
                                weight:
                                    "${controller.upcomingRoutes[position].totalWeights}",
                                pieces:
                                    "${controller.upcomingRoutes[position].totalPieces}",
                                routeStatus:
                                    "${controller.upcomingRoutes[position].routeStatus}",
                              );
                      }),
                );
              }
            },
          ),
        ],
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.width * .22,
            ),
            Image.asset(
              ImagesPaths.icMap,
              width: 200,
              height: 200,
            ),
            "No Route"
                .text
                .size(20)
                .fontWeight(FontWeight.w600)
                .color(AppColors.textGrey)
                .make()
                .marginOnly(top: 50.63),
            "Currently no route available in this store.\nYou could try other stores or try again."
                .text
                .size(12)
                .fontWeight(FontWeight.w500)
                .color(AppColors.textGrey)
                .make()
                .marginOnly(top: 11, bottom: 73),
            GestureDetector(
              onTap: () {
                controller.selectedStore.value =
                    controller.getStores[0].storeName!;
                controller.getRoutesData("${controller.getStores[0].id}??0");
              },
              child: Container(
                alignment: Alignment.center,
                height: 48,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(10)),
                child: "Try Again"
                    .text
                    .size(14)
                    .color(AppColors.white)
                    .fontWeight(FontWeight.w600)
                    .make(),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget routesItemWidget(
      {required HomeController controller,
      required String routeID,
      required String routeType,
      required String routeName,
      required String timing,
      required String stops,
      required String bag,
      required String weight,
      required String pieces,
      required String routeStatus}) {
    return Container(
      width: Get.width * .9,
      height: 270,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: routeStatus == "1"
            ? Border.all(color: AppColors.accent, width: 2)
            : Border.all(color: AppColors.white),
        boxShadow: [
          BoxShadow(
            color: AppColors.textGrey,
            blurRadius: 10.0, // Soften the shadow
            spreadRadius: 2.0,
            offset: const Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: routeStatus == "1" ? AppColors.accent : AppColors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                routeName.text
                    .size(18)
                    .color(
                      routeStatus == "2"
                          ? AppColors.completedRouteColor
                          : routeStatus == "1"
                              ? AppColors.white
                              : AppColors.black,
                    )
                    .fontWeight(FontWeight.w700)
                    .make(),
                timing.text
                    .color(
                      routeStatus == "2"
                          ? AppColors.completedRouteColor
                          : routeStatus == "1"
                              ? AppColors.white
                              : AppColors.black,
                    )
                    .size(12)
                    .fontWeight(FontWeight.w500)
                    .make()
              ],
            ).pLTRB(24, 16, 24, 9),
          ),
          routeStatus == "1"
              ? const SizedBox()
              : Divider(
                  color: routeStatus == "2" ? Colors.grey : Colors.black,
                  thickness: 1,
                  endIndent: 16,
                  indent: 16,
                ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: Get.width * .3,
                            height: 90,
                            child: FittedBox(
                              child: Column(
                                children: [
                                  stops.text
                                      .size(70)
                                      .color(
                                        routeStatus == "2"
                                            ? AppColors.completedRouteColor
                                            : AppColors.black,
                                      )
                                      .fontWeight(FontWeight.w500)
                                      .make(),
                                ],
                              ),
                            )),
                        Container(
                          child: "Stops"
                              .text
                              .size(14)
                              .color(
                                routeStatus == "2"
                                    ? AppColors.completedRouteColor
                                    : AppColors.textGrey,
                              )
                              .color(AppColors.completedRouteColor)
                              .fontWeight(FontWeight.w600)
                              .make()
                              .pLTRB(0, 0, 0, 20),
                        ),
                      ],
                    ).pLTRB(0, 14, 0, 0),
                    Container(
                      height: 130,
                      width: 2,
                      color: AppColors.darkGray,
                    ).px(10),
                    SizedBox(
                      width: Get.width * .3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesPaths.icBag,
                                    height: 16,
                                    width: 13.56,
                                    color: routeStatus == "2"
                                        ? AppColors.completedRouteColor
                                        : AppColors.black,
                                  ),
                                  "Bags"
                                      .text
                                      .size(12)
                                      .color(
                                        routeStatus == "2"
                                            ? AppColors.completedRouteColor
                                            : AppColors.black,
                                      )
                                      .fontWeight(FontWeight.w500)
                                      .italic
                                      .make()
                                      .pLTRB(12.22, 0, 0, 0),
                                ],
                              ),
                              bag.text
                                  .fontWeight(FontWeight.w700)
                                  .color(
                                    routeStatus == "2"
                                        ? AppColors.completedRouteColor
                                        : AppColors.black,
                                  )
                                  .size(18)
                                  .make(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesPaths.icWeight2,
                                    height: 16,
                                    width: 13.56,
                                    color: routeStatus == "2"
                                        ? AppColors.completedRouteColor
                                        : AppColors.black,
                                  ),
                                  "Weight"
                                      .text
                                      .size(12)
                                      .color(
                                        routeStatus == "2"
                                            ? AppColors.completedRouteColor
                                            : AppColors.black,
                                      )
                                      .fontWeight(FontWeight.w500)
                                      .italic
                                      .make()
                                      .pLTRB(12.22, 0, 0, 0),
                                ],
                              ),
                              weight.text
                                  .fontWeight(FontWeight.w700)
                                  .color(
                                    routeStatus == "2"
                                        ? AppColors.completedRouteColor
                                        : AppColors.black,
                                  )
                                  .size(18)
                                  .make(),
                            ],
                          ).py(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesPaths.icPieces,
                                    height: 18,
                                    width: 17.56,
                                    color: routeStatus == "2"
                                        ? AppColors.completedRouteColor
                                        : AppColors.black,
                                  ),
                                  "Pieces"
                                      .text
                                      .size(12)
                                      .color(
                                        routeStatus == "2"
                                            ? AppColors.completedRouteColor
                                            : AppColors.black,
                                      )
                                      .fontWeight(FontWeight.w500)
                                      .italic
                                      .make()
                                      .pLTRB(12.22, 0, 0, 0),
                                ],
                              ),
                              pieces.text
                                  .fontWeight(FontWeight.w700)
                                  .color(
                                    routeStatus == "2"
                                        ? AppColors.completedRouteColor
                                        : AppColors.black,
                                  )
                                  .size(18)
                                  .make(),
                            ],
                          ).py(5),
                        ],
                      ).paddingOnly(
                        top: 15,
                        left: 10,
                      ),
                    ),
                  ],
                ).pLTRB(30, 0, 30, 0),
                Divider(
                  thickness: 1,
                  color:
                      routeStatus == "1" ? AppColors.black : AppColors.textGrey,
                  endIndent: 16,
                  indent: 16,
                ).pLTRB(0, 5, 0, 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    "Current Status : "
                        .text
                        .size(12)
                        .color(
                          routeStatus == "2"
                              ? AppColors.completedRouteColor
                              : AppColors.black,
                        )
                        .fontWeight(FontWeight.w500)
                        .make(),
                    (routeStatus == "0"
                            ? "Not Started"
                            : routeStatus == "1"
                                ? "Running"
                                : "Completed")
                        .text
                        .size(12)
                        .italic
                        .color(AppColors.textGrey)
                        .fontWeight(FontWeight.w500)
                        .make(),
                  ],
                ).pLTRB(24, 0,  0, 11)
              ],
            ),
          )
        ],
      ),
    ).marginOnly(top: 15, left: 20, right: 20).onTap(() {
      if (routeStatus != "2") {
        RouteStatus status = RouteStatus.notStarted;
        controller.routeType = routeType;
        routeStatus == "0"
            ? status = RouteStatus.notStarted
            : routeStatus == "1"
                ? status = RouteStatus.running
                : status = RouteStatus.completed;
        controller.onTapRouteItemWidget(routeId: routeID, status: status);
      } else {
        printData("Invalid");
      }
    });
  }
}
