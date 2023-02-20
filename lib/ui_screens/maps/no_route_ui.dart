import 'package:driver/controllers/no_route_controllers.dart';
import 'package:driver/utils/localization/app_colors.dart';
import 'package:driver/utils/localization/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class NoRouteUi extends StatelessWidget {
  const NoRouteUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoRouteControllers controllers = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagesPaths.icMap,width: 200,height: 200,),
            "No Route".text.size(20).fontWeight(FontWeight.w600).color(AppColors.textGrey).make().pOnly(top: 50.63),
            "Currently no route available in this store.\nYou could try other stores or try again.".text.size(12).fontWeight(FontWeight.w500)
                .color(AppColors.textGrey).make().pOnly(top: 11,bottom: 73),
            Container(
              alignment: Alignment.center,
              height: 48,
              width: Get.width *0.4,
              decoration: BoxDecoration(color: AppColors.lightGreen,borderRadius: BorderRadius.circular(10)),
              child: "Try Again".text.size(14).color(AppColors.white).fontWeight(FontWeight.w600).make(),
            )
          ],
        ),
      ),
    );
  }


}
