import 'package:driver/controllers/enter_otp_controllers.dart';
import 'package:driver/utils/localization/app_colors.dart';
import 'package:driver/utils/localization/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:velocity_x/velocity_x.dart';

class EnterOtpUI extends StatelessWidget {
  const EnterOtpUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnterOtpControllers controllers = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                ImagesPaths.imgOtp,
                height: 150.7,
                width: 137.52,
              ).centered().pLTRB(0, 79.1, 0, 73.1),
              "Business Id".text.fontWeight(FontWeight.w400).size(12).make(),
             controllers.businessID.value
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
                      controllers.phoneNumber.value
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
              "Enter your OTP here"
                  .text
                  .fontWeight(FontWeight.w500)
                  .color(AppColors.textGrey)
                  .size(12)
                  .make()
                  .pLTRB(0, 36, 0, 10),

              // otp fill
              otpField(context, controllers),

              // error password
              // Obx(() => controllers.isCorrect.value == true
              //     ? const SizedBox().pLTRB(0, 15, 0, 0)
              //     : "Wrong OTP entered "
              //         .text
              //         .color(AppColors.red)
              //         .semiBold
              //         .make()).pLTRB(0, 15, 0, 66),

              Obx(
                () => Visibility(
                        visible: controllers.isCorrect.value,
                        child: "Wrong OTP entered ".text.fontWeight(FontWeight.w500).size(14).color(AppColors.red)
                            
                            .make())
                    .pLTRB(0,5, 0, 61),
              ),

              // timer otp resend
              Obx(() => controllers.resendOTP.value
                  ? Container(
                      height: 40,
                      width: 130,
                      decoration: BoxDecoration(
                          color: AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10)),
                      child: "Resend OTP"
                          .text
                          .size(14)
                          .fontWeight(FontWeight.w600)
                          .color(
                            AppColors.lightBlack,
                          )
                          .make()
                          .centered(),
                    ).onTap(() {
                      controllers.onTapResend();
                    }).centered()
                  : "Resend OTP in ${controllers.setTimer.value.toString()} sec"
                      .text.size(14)
                      .fontWeight(FontWeight.w500)
                      .color(AppColors.black)
                      .semiBold
                      .make()).centered(),
            ],
          ).px(31),
        ),
      ),
    );
  }

  Widget otpField(BuildContext context, EnterOtpControllers controllers) {
    return PinCodeTextField(
      inputFormatters: [

        FilteringTextInputFormatter.digitsOnly
      ],
      length: 4,
      controller: controllers.otpController,
      obscureText: false,
      cursorColor: AppColors.accent,
      keyboardType: TextInputType.phone,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        selectedColor:  AppColors.black,
        selectedFillColor:  AppColors.black,
        inactiveColor:  AppColors.black,
        disabledColor: AppColors.black,
        activeColor:  AppColors.black,
        errorBorderColor:  AppColors.black,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        borderWidth: 1,
        fieldHeight: 60,
        fieldWidth: 60,
        activeFillColor: Colors.blue,
      ),
      onCompleted: (value) {
        controllers.loginUserAPI();
      },
      onChanged: (value) {
       controllers. isCorrect.value = false;
      },
      appContext: context,
    );

  }
}
