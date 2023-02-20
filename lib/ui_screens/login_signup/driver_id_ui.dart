import 'package:country_code_picker/country_code_picker.dart';
import 'package:driver/controllers/driver_id_controllers.dart';
import 'package:driver/utils/localization/app_colors.dart';
import 'package:driver/utils/localization/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/localization/print_data.dart';

class DriverIdUi extends StatelessWidget {
  const DriverIdUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DriverIDControllers controller = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Image.asset(
              ImagesPaths.imgDriver,
              width: 113,
              height: 159,
            ).pLTRB(0, 78, 0, 45.25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Business Id"
                        .text
                        .semiBold
                        .color(AppColors.black)
                        .size(12)
                        .make(),
                    controller.businessID.value.text
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
            ).pLTRB(31, 0, 36.55, 56),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Sign in "
                      .text
                      .bold
                      // .fontWeight(FontWeight.w400)
                      .size(16)
                      .make(),
                  "Your Driver ID "
                      .text
                      .bold
                      .fontWeight(FontWeight.w700)
                      .color(AppColors.accent)
                      .size(26)
                      .align(TextAlign.start)
                      .make()
                ],
              ),
            ).px(31),
            usMobileNumber(context, controller).pLTRB(0, 22, 0, 0),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: Get.width * 0.38,
                      decoration: BoxDecoration(
                          color: controller.isValidated.value
                              ? AppColors.lightGreen
                              : AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10)),
                      child: "Enter PIN"
                          .text
                          .size(14)
                          .fontWeight(FontWeight.w600)
                          .color(
                            controller.isValidated.value
                                ? AppColors.white
                                : AppColors.lightBlack,
                          )
                          .make()
                          .centered(),
                    ).px(10).onTap(() {
                      controller.getOtpOrPin(hitType: HitType.enterPin);
                    }),
                    Container(
                      height: 40,
                      width: Get.width * 0.38,
                      decoration: BoxDecoration(
                          color: controller.isValidated.value
                              ? AppColors.lightGreen
                              : AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10)),
                      child: "Get OTP"
                          .text
                          .size(14)
                          .fontWeight(FontWeight.w600)
                          .color(
                            controller.isValidated.value
                                ? AppColors.white
                                : AppColors.lightBlack,
                          )
                          .make()
                          .centered(),
                    ).onTap(() {
                      controller.getOtpOrPin(hitType: HitType.getOtp);
                    }),
                  ],
                ).centered().pOnly(top: 100, right: 10))
          ],
        )),
      ),
    );
  }

  Widget inMobileNumber(BuildContext context, DriverIDControllers controllers) {
    return Row(
      children: [
        Container(
          height: 48,
          width: Get.width * 0.84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.textGrey),
          ),
          child: TextFormField(
            maxLength: 10,
            onChanged: (phone) {
              //get complete number
              controllers.validatePhone();
            },
            controller: controllers.phoneController,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: country(context, controllers),
              border: InputBorder.none,
              hintText: "Example : 98765 43210",
              fillColor: Colors.white,
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGray),
            ),
          ),
        ),
      ],
    ).pOnly(left: 31, right: 31);
  }

  Widget usMobileNumber(BuildContext context, DriverIDControllers controllers) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(###) ###-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return Row(
      children: [
        Container(
          height: 48,
          width: Get.width * 0.84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.textGrey),
          ),
          child:

              // TextField(inputFormatters: [maskFormatter]),
              TextFormField(
            // maxLength: 10,
            onChanged: (phone) {
              //get complete number
              controllers.validatePhone();
              printData("${phone.length}");
            },
            controller: controllers.phoneController,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            keyboardType: TextInputType.number,
            inputFormatters: [maskFormatter],
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: country(context, controllers),
              border: InputBorder.none,
              hintText: "Example : 98765 43210",
              fillColor: Colors.white,
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGray),
            ),
          ),
        ),
      ],
    ).pOnly(left: 31, right: 31);
  }

  Widget country(BuildContext context, DriverIDControllers controllers) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CountryCodePicker(
          enabled: false,
          onInit: (val) {
            controllers.countryCodePrefix = "${val?.dialCode}";
            printData(
                "CODE: ${val!.code}, FLAG_URI: ${val.flagUri}, NAME ${val.name} ${val.dialCode}");
          },
          onChanged: (code) {
            controllers.phoneCode("${code.dialCode}");
          },
          initialSelection: controllers.countryCode.value,
          hideMainText: false,
          padding: const EdgeInsets.only(right: 2, left: 2),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.black,
          ),
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
        ),

        Column(
          children: [
            Container(
              height: 46,
              width: 1,
              // color: const Color(0xFFD9DDE6),
              color: Colors.grey,
            ).pOnly(right: 6),
          ],
        ),
        // VerticalDivider(
        //   color: Colors.black,
        //   thickness: 1,
        // ).pLTRB(0, 0,8, 0)
      ],
    );
  }
}
