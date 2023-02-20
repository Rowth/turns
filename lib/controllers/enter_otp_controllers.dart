import 'dart:async';

import 'package:driver/controllers/driver_id_controllers.dart';
import 'package:driver/services/networking_services/api_call.dart';
import 'package:driver/utils/routes/my_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/localization/SharedPrefKeys.dart';
import 'business_id_controllers.dart';

class EnterOtpControllers extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxBool resendOTP = false.obs;
  RxBool isCorrect = false.obs;
  String mobileNum = "";
  RxInt setTimer = 30.obs;
  BusinessIDControllers controllers = Get.find();
  DriverIDControllers driverIDControllers = Get.find();
  RxString businessID = "".obs;
  Timer timer = Timer(Duration.zero, () {});
  RxString phoneNumber = "".obs;

  @override
  void onInit() {
    businessID.value = controllers.businessIdTextController.text;
    phoneNumber.value = driverIDControllers.phoneNumber.value;
    timerSettingFunction();
    super.onInit();
  }

  timerSettingFunction() {
    resendOTP.value = false;
    setTimer.value = 30;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (setTimer.value > 0) {
          setTimer.value--;
        } else {
          timer.cancel();
          resendOTP.value = true;
        }
      },
    );
  }

  void loginUserAPI() {
    DriverIDControllers controllers = Get.find();

    var loginRequestModel = {
      "mobile": controllers.formattedPhone,
      "type": "OTP",
      "otp_pin": otpController.text
    };

    printData("REQUEST DATA : $loginRequestModel");

    CallAPI().loginDriver(loginRequestModel: loginRequestModel).then((value) {
      if (value.status == true) {
        GetStorage storage = GetStorage();
        storage.write(SharedPrefrencesKeys.IS_LOGGED_IN, true);
        storage.write(SharedPrefrencesKeys.USER_ID_KEY,
            "${value.data?.employeeData?.userId}");
        storage.write(
            SharedPrefrencesKeys.ACCESS_TOKEN_KEY, value.data?.accessToken);
        storage.write(
            SharedPrefrencesKeys.REFRESH_TOKEN_KEY, value.data?.refreshToken);
        storage.write(SharedPrefrencesKeys.USER_NAME,
            "${value.data?.employeeData!.firstName} ${value.data?.employeeData!.lastName}");
        storage.write(SharedPrefrencesKeys.USER_PHONE,
            "${value.data?.employeeData!.countryCode}-${value.data?.employeeData!.mobile}");
        isCorrect.value = false;
        Get.offAllNamed(MyRoutes.homePageUI);
      } else {
        isCorrect.value = true;
        Get.snackbar(
          "Turns Fleet",
          "Wrong OTP Entered",
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  passwordSet() {
    if (otpController.text == "1234") {
      printData("password true");

      isCorrect.value = false;
      Get.offAllNamed(MyRoutes.homePageUI);
    } else if (!RegExp('[0-9]').hasMatch(otpController.text)) {
      Get.snackbar(
        "Turns Fleet",
        "Please Enter a Valid otp",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      isCorrect.value = true;
      printData("password  false");
    }
  }

  printData(message) {
    if (kDebugMode) {
      print("className:EnterOtpControllers, $message");
    }
  }

  void onTapResend() {

    DriverIDControllers driverIDControllers = Get.find();
    var phoneRequestModel = {"mobile": driverIDControllers.formattedPhone};
    timerSettingFunction();
    CallAPI().resendOTP(phoneRequestModel: phoneRequestModel).then((value) {
      if (value.status == true) {
        Get.snackbar(
          "Turns Fleet",
          "${value.message}",
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          "Turns Fleet",
          "${value.message}",
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }
}
