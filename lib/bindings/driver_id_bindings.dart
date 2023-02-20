import 'package:get/get.dart';

import '../controllers/driver_id_controllers.dart';

class DriverIDBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DriverIDControllers());
  }
}
