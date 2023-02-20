import 'package:driver/controllers/maps_with_route_controllers.dart';
import 'package:get/get.dart';

class MapsWithRouteBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(MapsWithRoutesControllers());
  }

}