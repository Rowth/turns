import 'package:driver/controllers/business_id_controllers.dart';
import 'package:driver/icons.dart';
import 'package:driver/utils/localization/app_colors.dart';
import 'package:driver/utils/localization/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class BusinessIdUi extends StatelessWidget {
  const BusinessIdUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BusinessIDControllers controllers = Get.find();
    return SafeArea(
      child:
      Scaffold(
           body:
          Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: Get.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )),
                    child:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Image.asset(
                            ImagesPaths.imgTruck,
                            width: 146,
                            height: 156,
                          ).centered().pLTRB(0, 77.89, 0, 14),
                          "Sign in"
                              .text
                              .size(15)
                              .color(AppColors.black)
                              .bold
                              .make()
                              .pLTRB(32, 0, 0, 0),
                          "Your Business ID"
                              .text
                              .color(AppColors.accent)
                              .size(25)
                              .bold
                              .make()
                              .pLTRB(32, 0, 0, 0),
                          SizedBox(
                              height: 48,
                              child: TextFormField(
                                onChanged: (value) {

                                  controllers.idValidator();
                                },
                                controller: controllers.businessIdTextController,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),

                                decoration: InputDecoration(

                                    contentPadding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: "Example : yu097yu56",
                                    hintStyle: TextStyle(
                                        color: AppColors.darkGray,
                                        fontWeight: FontWeight.w900)),
                              )).pLTRB(31,21, 31, 10),

                        ])),
                //Continue button
                SizedBox(
                  height: 68,
                  width: Get.width,
                  // color: Colors.grey,
                  child: Column(
                    children: [

                      Obx(
                            () => Container(
                            height: 40,
                            width: Get.width * .7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: controllers.isValidId.value
                                    ? AppColors.accent
                                    : AppColors.darkGray,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(2),
                            child: "Continue"
                                .text
                                .size(14)
                                .fontWeight(FontWeight.w600)
                                .color(controllers.isValidId.value
                                ? AppColors.white
                                : AppColors.black)
                                .semiBold
                                .make())
                            .px(72)
                            .centered()
                            .onTap(() {
                          controllers.onTabContinue(context);
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      )
      // Scaffold(
      //     body: SingleChildScrollView(
      //         physics: const BouncingScrollPhysics(),
      //         child:
      //         Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Image.asset(
      //                 ImagesPaths.imgTruck,
      //                 width: 146,
      //                 height: 156,
      //               ).centered().pLTRB(0, 77.89, 0, 164),
      //               "Sign in"
      //                   .text
      //                   .size(15)
      //                   .color(AppColors.black)
      //                   .bold
      //                   .make()
      //                   .pLTRB(32, 0, 0, 0),
      //               "Your Business ID"
      //                   .text
      //                   .color(AppColors.accent)
      //                   .size(25)
      //                   .bold
      //                   .make()
      //                   .pLTRB(32, 0, 0, 0),
      //               SizedBox(
      //                   height: 48,
      //                   child: TextFormField(
      //                     onChanged: (value) {
      //
      //                       controllers.idValidator();
      //                     },
      //                     controller: controllers.businessIdTextController,
      //                       style: const TextStyle(
      //                           fontWeight: FontWeight.w600,
      //                           fontSize: 16
      //                       ),
      //
      //                     decoration: InputDecoration(
      //
      //                         contentPadding:
      //                             const EdgeInsets.only(top: 10, left: 10),
      //                         border: OutlineInputBorder(
      //                           borderRadius: BorderRadius.circular(10),
      //                         ),
      //                         hintText: "Example : yu097yu56",
      //                         hintStyle: TextStyle(
      //                             color: AppColors.darkGray,
      //                             fontWeight: FontWeight.w900)),
      //                   )).pLTRB(31, 24, 31, 120),
      //               Obx(
      //                 () => Container(
      //                         height: 40,
      //                         width: Get.width * .7,
      //                         alignment: Alignment.center,
      //                         decoration: BoxDecoration(
      //                             color: controllers.isValidId.value
      //                                 ? AppColors.accent
      //                                 : AppColors.darkGray,
      //                             borderRadius: BorderRadius.circular(10)),
      //                         padding: const EdgeInsets.all(2),
      //                         child: "Continue"
      //                             .text
      //                             .size(14)
      //                             .fontWeight(FontWeight.w600)
      //                             .color(controllers.isValidId.value
      //                                 ? AppColors.white
      //                                 : AppColors.black)
      //                             .semiBold
      //                             .make())
      //                     .px(72)
      //                     .centered()
      //                     .onTap(() {
      //                   controllers.onTabContinue(context);
      //                 }),
      //               ),
      //             ])
      //     )
      // ),
    );
  }
}
