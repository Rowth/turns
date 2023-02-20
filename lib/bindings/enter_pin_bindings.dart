import 'package:driver/controllers/enter_otp_controllers.dart';
import 'package:driver/controllers/enter_pin_controllers.dart';
import 'package:get/get.dart';

class EnterPinBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(EnterPinController());
  }
}
