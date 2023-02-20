import 'package:driver/controllers/home_controller.dart';
import 'package:driver/ui_screens/maps/maps_wih_route_ui.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }

}