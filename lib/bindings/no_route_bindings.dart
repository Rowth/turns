import 'package:driver/controllers/no_route_controllers.dart';
import 'package:get/get.dart';

class NoRoutBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NoRouteControllers());
    // TODO: implement dependencies
  }

}