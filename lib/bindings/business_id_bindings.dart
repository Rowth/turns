import 'package:driver/controllers/business_id_controllers.dart';
import 'package:get/get.dart';

class BusinessIDBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(BusinessIDControllers());
  }

}