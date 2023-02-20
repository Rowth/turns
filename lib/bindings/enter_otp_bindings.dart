import 'package:driver/controllers/enter_otp_controllers.dart';
import 'package:get/get.dart';

class EnterOtpBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(EnterOtpControllers());
  }

}