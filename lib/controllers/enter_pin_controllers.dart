// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:driver/services/networking_services/api_call.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/localization/SharedPrefKeys.dart';
import '../utils/routes/my_routes.dart';
import 'business_id_controllers.dart';
import 'driver_id_controllers.dart';

class EnterPinController extends GetxController {
  TextEditingController pinController = TextEditingController();

  RxBool isCorrect = false.obs;
  BusinessIDControllers controllers = Get.find();
  DriverIDControllers driverIDControllers = Get.find();
  String businessID = "";
  String phoneNumber = "";

  @override
  void onInit() {
    businessID = "${controllers.businessIdTextController.text} ";
    phoneNumber = "${driverIDControllers.phoneNumber.value} ";
    super.onInit();
  }

  String encryptedPIN(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  validatePIN() {

    DriverIDControllers controllers = Get.find();
    var encryptedMd5PIN = encryptedPIN(pinController.text);
    var mobile = controllers.formattedPhone;

    var loginRequestData = {
      'mobile': mobile,
      "type": "PIN",
      "otp_pin": encryptedMd5PIN
    };

    printData(loginRequestData);

    CallAPI().loginDriver(loginRequestModel: loginRequestData).then((value) {
      if (value.status == true) {
        isCorrect.value = false;
        GetStorage storage = GetStorage();
        storage.write(SharedPrefrencesKeys.IS_LOGGED_IN, true);
        storage.write(SharedPrefrencesKeys.USER_ID_KEY,
            "${value.data?.employeeData?.userId}");
        storage.write(
            SharedPrefrencesKeys.ACCESS_TOKEN_KEY, value.data?.accessToken);
        storage.write(
            SharedPrefrencesKeys.REFRESH_TOKEN_KEY, value.data?.refreshToken);
        storage.write(
            SharedPrefrencesKeys.USER_NAME, "${value.data?.employeeData!.firstName} ${value.data?.employeeData!.lastName}");
        storage.write(
            SharedPrefrencesKeys.USER_PHONE, "${value.data?.employeeData!.countryCode}-${value.data?.employeeData!.mobile}");
        Get.offAllNamed(MyRoutes.homePageUI);
      } else {
        isCorrect.value = true;
        Get.snackbar(
          "Turns Fleet",
          value.message ?? "Invalid PIN",
          snackPosition: SnackPosition.TOP,
        );
      }
    });
    // if (pinController.text == "1234") {
    //   isCorrect.value = false;
    //   printData("${pinController.text} matched");
    //   Get.offAllNamed(MyRoutes.homePageUI);
    // } else {
    //   isCorrect.value = true;
    //   printData("${pinController.text} not matched");
    // }
  }

  printData(message) {
    if (kDebugMode) {
      print("className:EnterPinController, $message");
    }
  }
}
