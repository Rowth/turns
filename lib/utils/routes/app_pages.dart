import 'package:driver/bindings/business_id_bindings.dart';
import 'package:driver/bindings/driver_id_bindings.dart';
import 'package:driver/bindings/enter_otp_bindings.dart';
import 'package:driver/bindings/enter_pin_bindings.dart';
import 'package:driver/bindings/home_bindings.dart';
import 'package:driver/bindings/maps_with_route_bindings.dart';
import 'package:driver/bindings/no_route_bindings.dart';
import 'package:driver/ui_screens/home_ui.dart';
import 'package:driver/ui_screens/login_signup/business_id_ui.dart';
import 'package:driver/ui_screens/login_signup/no_internet_ui.dart';
import 'package:driver/ui_screens/maps/maps_wih_route_ui.dart';
import 'package:driver/ui_screens/maps/no_route_ui.dart';
import 'package:get/get.dart';

import '../../bindings/no_internet_bindings.dart';
import '../../bindings/splash_bindings.dart';
import '../../ui_screens/login_signup/driver_id_ui.dart';
import '../../ui_screens/login_signup/enter_otp_ui.dart';
import '../../ui_screens/login_signup/enter_pin_ui.dart';
import '../../ui_screens/login_signup/splash_screen_ui.dart';
import 'my_routes.dart';

class AppPages {
  static String initialRoute = MyRoutes.splashUI;



  static final routes = [
    GetPage(
      name: MyRoutes.splashUI,
      page: () => const SplashScreenUI(),
      binding: SplashBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.businessIdUI,
      page: () => const BusinessIdUi(),
      binding: BusinessIDBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.driverIdUI,
      page: () => const DriverIdUi(),
      binding: DriverIDBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.enterOtpUI,
      page: () => const EnterOtpUI(),
      binding: EnterOtpBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.enterPinUI,
      page: () => const EnterPinUI(),
      binding: EnterPinBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.homePageUI,
      page: () => const HomeUI(),
      binding: HomeBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.mapsWihRouteUI,
      page: () => const MapsWihRouteUI(),
      binding: MapsWithRouteBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ), GetPage(
      name: MyRoutes.getBackHomeUI,
      page: () => const HomeUI(),
      binding: HomeBindings(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.noRouteUI,
      page: () => const NoRouteUi(),
      binding: NoRoutBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: MyRoutes.noInternetUI,
      page: () => const NoInternetUi(),
      binding: NoInternetBindings(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 700),
    ),
  ];
}
