import 'package:get/get.dart';

import '../controllers/splash_controllers.dart';

class SplashBindings  implements Bindings{
  @override
  void dependencies() {
    Get.put(SplashControllers());
  }
}