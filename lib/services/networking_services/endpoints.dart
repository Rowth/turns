// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:driver/utils/localization/SharedPrefKeys.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class Endpoints {
  //Base Urls Endpoints

  static String BASE_URL =
      "http://sifabso.com/development//index.php/routeapi/api/";
  static const String dynamicBaseURL = "";
  // ACCOUNTS API's
  static const String epBusinessLogin = "accounts/businessLogin";
  static const String epDriverOTP = "accounts/getDriverOTP";
  static const String epDriverResendOTP = "accounts/ResendOTP";
  static const String epDriverLogin = "accounts/driverLogin";

  //  AFTER LOGGED IN
  static const String epStoreDropdown = "storeDropdown";
  static const String epUpdateToken = "update_token";
  static const String epDriverRouteList = "driverRouteList";
  static const String epDriverStopList = "driverStopList";
  static const String epDriverStopDetails = "driverStopdetail";
  static const String epDriverNotes = "drivernotes";
  static const String epDriverUpdateStop = "driverUpdateStop";
  static const String epStartRoute = "driverstartroute";
  static const String epCompleteRoute = "drivercompleteroute";

  GetStorage storage = GetStorage();

  void saveBaseUrl() {
    printData("NEW BASE URL IS: $BASE_URL");
    storage.write(SharedPrefrencesKeys.BASE_URL_KEY, BASE_URL);
    printData(
        "BASE_URL_FROM ${storage.read(SharedPrefrencesKeys.BASE_URL_KEY)}");
  }

  void updateBaseUrl(String businessID) {
    BASE_URL =
        "http://sifabso.com/development/$businessID/index.php/routeapi/api/";
  }

  void printData(object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
