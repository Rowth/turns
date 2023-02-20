import 'package:driver/controllers/no_internet_controllers.dart';
import 'package:get/get.dart';

class NoInternetBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NoInternetController());
    // TODO: implement dependencies
  }

}