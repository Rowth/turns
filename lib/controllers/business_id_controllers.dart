import 'package:driver/services/networking_services/api_call.dart';
import 'package:driver/services/networking_services/endpoints.dart';
import 'package:driver/services/request_model/business_id_request_model.dart';
import 'package:driver/utils/routes/my_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/response_models/accounts/business_id_response_model.dart';

class BusinessIDControllers extends GetxController {
  TextEditingController businessIdTextController = TextEditingController();
  RxBool isValidId = false.obs;
  String countryCode = "";

  Future<BusinessIDResponseModel> validateBusinessID() async {
    var loginRequestModel =
        BusinessIDRequestModel(businessName: businessIdTextController.text)
            .toJson();

    BusinessIDResponseModel model =
        await CallAPI().validateBusiness(loginRequestModel: loginRequestModel);

    return model;
  }

  idValidator() {
    printData(businessIdTextController.text);

    Endpoints().updateBaseUrl(businessIdTextController.text);

    isValidId.value = false;
    validateBusinessID().then((value) {
      printData("STATUS ${value.status}");
      if (value.status == true) {
        isValidId.value = true;
        countryCode = "${value.data?.countryCode}";
        Endpoints().saveBaseUrl();
      }
    }).onError((error, stackTrace) => printData("$error $stackTrace"));
  }

  onTabContinue(BuildContext context) {
    if (isValidId.value == true) {
      printData("Continue");
      Get.toNamed(MyRoutes.driverIdUI);
    } else {
      Get.snackbar(
        "Turns Fleet",
        "Not a valid Business ID",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  printData(message) {
    if (kDebugMode) {
      print("className:BusinessIDControllers, $message");
    }
  }
}
