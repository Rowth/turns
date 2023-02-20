import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/localization/SharedPrefKeys.dart';
import '../utils/routes/my_routes.dart';

class SplashControllers extends GetxController {
  @override
  void onInit() {
    GetStorage storage = GetStorage();

    Future.delayed(const Duration(seconds: 5)).then((value) {
      String token = storage.read(SharedPrefrencesKeys.ACCESS_TOKEN_KEY)??"";
      if (token == "") {
        Get.offAllNamed(MyRoutes.businessIdUI);
      } else {
        Get.offAllNamed(MyRoutes.homePageUI);
      }
      printData(
          "TOKEN : ${storage.read(SharedPrefrencesKeys.ACCESS_TOKEN_KEY)}");
    });
    super.onInit();
  }

  void printData(object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
