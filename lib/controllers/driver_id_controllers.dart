import 'package:driver/controllers/business_id_controllers.dart';
import 'package:driver/services/networking_services/api_call.dart';
import 'package:driver/utils/routes/my_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DriverIDControllers extends GetxController {
  TextEditingController phoneController = TextEditingController();
  RxString countryCode = "".obs;
  String countryCodePrefix = "";
  String formattedPhone = "";
  BusinessIDControllers controllers = Get.find();
  RxString businessID = "".obs;
  RxString phoneNumber = "".obs;
  RxBool isValidated = false.obs;

  @override
  void onInit() {
    countryCode.value = controllers.countryCode;
    businessID.value = "${controllers.businessIdTextController.text} ";
    super.onInit();
  }

  void phoneCode(String code) {
    countryCode.value = code;
  }

  void validatePhone() {
    if (phoneController.text.isEmpty ) {
      Get.snackbar(
        "Turns Fleet",
        "Please enter valid mobile number",
        snackPosition: SnackPosition.TOP,
      );
    }

    if (phoneController.text.length == 14) {
      isValidated.value = true;
    } else if (phoneController.text.length < 14) {
      isValidated.value = false;
    } else {
      isValidated.value = false;
    }
    // if (phoneController.text.length == 10) {
    //   isValidated.value = true;
    // } else if (phoneController.text.length < 10) {
    //   isValidated.value = false;
    // } else {
    //   isValidated.value = false;
    // }
  }

  void getOtpOrPin({required HitType hitType}) {

    formattedPhone = getUSFormatted();
    if (hitType == HitType.getOtp && isValidated.value == true) {
      printData(hitType.toString());
      sendOTP();
    } else if (hitType == HitType.enterPin && isValidated.value == true) {
      printData(hitType.toString());
      phoneNumber.value = "$countryCodePrefix-${phoneController.text}";
      Get.toNamed(MyRoutes.enterPinUI);
    } else if (!RegExp('^[0-9]*').hasMatch(phoneController.text)) {
      Get.snackbar(
        "Turns Fleet",
        "Please Enter a Valid Phone Number",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "Turns Fleet",
        "Not a Valid Phone No.",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  printData(message) {
    if (kDebugMode) {
      print("className:DriverIDControllers, $message");
    }
  }

  String getUSFormatted() {
    String phoneNum = phoneController.text;
    phoneNum = phoneNum.replaceAll(")", "");
    phoneNum = phoneNum.replaceAll("(", "");
    phoneNum = phoneNum.replaceAll("-", "");
    phoneNum = phoneNum.replaceAll(" ", "");

    printData(phoneNum);
    return phoneNum;
  }

  void sendOTP() async {

    var phoneRequestModel = {"mobile": formattedPhone};
    // var phoneRequestModel = {"mobile": phoneController.text};

    await CallAPI().sendOTP(phoneRequestModel: phoneRequestModel).then((value) {
      if (value.status == true) {
        phoneNumber.value = "$countryCodePrefix-${phoneController.text}";
        Get.snackbar(
          "Turns Fleet",
          "${value.message}",
          snackPosition: SnackPosition.TOP,
        );
        Get.toNamed(MyRoutes.enterOtpUI);
      } else {
        Get.snackbar(
          "Turns Fleet",
          " ${value.message ?? "Invalid Mobile Phone"}",
          snackPosition: SnackPosition.TOP,
        );
      }
    }).onError((error, stackTrace) {
      printData("ERROR: $error $stackTrace");
    });
  }
}

enum HitType { getOtp, enterPin }
