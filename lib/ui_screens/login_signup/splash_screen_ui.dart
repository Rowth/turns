import 'package:driver/utils/localization/app_colors.dart';
import 'package:driver/utils/localization/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreenUI extends StatelessWidget {
  const SplashScreenUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.accent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.accent,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/ic_app_logo.png",
                    width: Get.width * .3,
                    height: Get.height*.5,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/ic_delivery.png",
                        height: 50,
                        width: 50,
                      ),
                      Transform(
                              alignment: Alignment.center,
                              transform:
                                  Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
                              child: const LinearProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  valueColor:
                                      AlwaysStoppedAnimation(AppColors.white),
                                  minHeight: 3))
                          .w(100)
                    ],
                  ),
                ],
              ),
            )

// Stack(
//   children: [
//     Container(
//       alignment: Alignment.center,
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFF1D794A),
//                 Color(0xFF319964),
//               ],
//               tileMode: TileMode.clamp)),
//       child:
//
//       SizedBox(
//         width: (Get.width) / 3,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Image.asset(
//               ImagesPaths.icAppLogo,
//               width: Get.width * .3,
//             ),
//             Column(
//               children: [
//                 Image.asset(
//                   ImagesPaths.icDeliveryTruck,
//                   height: 50,
//                   width: 50,
//                 ),
//                 Transform(
//                         alignment: Alignment.center,
//                         transform:
//                             Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
//                         child: const LinearProgressIndicator(
//                             backgroundColor: Colors.transparent,
//                             valueColor:
//                                 AlwaysStoppedAnimation(AppColors.white),
//                             minHeight: 3))
//                     .w(100)
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   ],
// ),
            ));
  }
}
