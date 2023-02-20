import 'package:driver/utils/localization/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/localization/app_colors.dart';
class NoInternetUi extends StatelessWidget {
  const NoInternetUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(child:    Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagesPaths.icNoInternet,height: 168,width: 202,),
            "No Internet".text.center.size(20).fontWeight(FontWeight.w600).color(AppColors.textGrey).make().pOnly(top: 97.57),
            "No internet found.\nPlease check your network connection".text.center.size(12).fontWeight(FontWeight.w600).color(AppColors.textGrey).make().pOnly(top: 10,bottom: 73),
            Container(
              alignment: Alignment.center,
              height: 48,
              width: Get.width*0.4,
              decoration: BoxDecoration(
                  color:AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: "Try Again".text.white.fontWeight(FontWeight.w600).size(14).make(),
            )
          ],
        ),
      ));
  }
}
