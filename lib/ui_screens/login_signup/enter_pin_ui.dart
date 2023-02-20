import 'dart:math';

import 'package:driver/controllers/enter_pin_controllers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/localization/app_colors.dart';
import '../../utils/localization/images_paths.dart';

class EnterPinUI extends StatelessWidget {
  const EnterPinUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnterPinController controllers = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                ImagesPaths.imgPin,
                height: 150.7,
                width: 137.52,
              ).centered().pLTRB(0, 79.1, 0, 73.1),
              "Business Id".text.fontWeight(FontWeight.w400).size(12).make(),
              controllers.businessID
                  .text
                  .fontWeight(FontWeight.w600)
                  .size(16)
                  .make()
                  .pLTRB(0, 2, 0, 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Driver id"
                          .text
                          .fontWeight(FontWeight.w400)
                          .size(12)
                          .make(),
                      controllers.phoneNumber
                          .text
                          .fontWeight(FontWeight.w600)
                          .size(16)
                          .make(),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    color: AppColors.transparent,
                    child: Image.asset(
                      ImagesPaths.imgEdit,
                      width: 15.83,
                      height: 17.41,
                    ),
                  ).onTap(() {
                    Get.back();
                  }),
                ],
              ),
              "Enter your PIN here"
                  .text
                  .fontWeight(FontWeight.w500).color(AppColors.textGrey)
                  .size(12)
                  .make()
                  .pLTRB(0, 36, 0, 5),
              pinBox(context, controllers),
              Obx(() => Visibility(
                  visible: controllers.isCorrect.value,
                  child: "Incorrect PIN"
                      .text
                      .color(AppColors.red)
                      .semiBold
                      .make().centered()
                      .py(75))),
            ],
          ).px(31),
        ),
      ),
    );
  }

  Widget pinBox(
    BuildContext context,
    EnterPinController controller,
  ) {
    return PinCodeTextField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      length: 4,
      controller: controller.pinController,
      obscureText: false,
      cursorColor: AppColors.accent,
      keyboardType: TextInputType.phone,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        selectedColor: const Color(0xFF999999),
        selectedFillColor: const Color(0xFF999999),
        inactiveColor: const Color(0xFF999999),
        disabledColor: const Color(0xFF999999),
        activeColor: const Color(0xFF999999),
        errorBorderColor: const Color(0xFF999999),
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 60,
        fieldWidth: 60,
        activeFillColor: Colors.blue,
      ),
      onChanged: (value) {},
      onCompleted: (value) {
        controller.validatePIN();
      },
      appContext: context,
    );
  }
}
