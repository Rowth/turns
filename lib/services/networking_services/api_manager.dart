// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../utils/localization/SharedPrefKeys.dart';
import 'custom_exception.dart';
import 'endpoints.dart';

class APIManager {
  GetStorage storage = GetStorage();

  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  Future<dynamic> getAllCall({required String endPoint}) async {
    String newBaseURL = storage.read(SharedPrefrencesKeys.BASE_URL_KEY);

    printData("NEW BASE URL ${newBaseURL.toString()}");

    Uri urlForPost = Uri.parse("$newBaseURL$endPoint");
    var responseJson;
    String getToken = "";
    String getUserID = "";
    String currentDate = "";
    currentDate = getDate();
    getToken = storage.read(SharedPrefrencesKeys.ACCESS_TOKEN_KEY);
    getUserID = storage.read(SharedPrefrencesKeys.USER_ID_KEY);

    printData("URL For Get is: $urlForPost");

    var headers = {
      'X-App-Name': '1.0.0.0',
      'X-App-Version': '10000',
      'OS-Version': '24',
      'Authorization': 'Bearer $getToken',
      'X-Date': currentDate,
      'Content-type': 'application/json',
      'X-Store-ID': "8",
      'X-Platform': "DRIVER_APP",
      'X-User-ID': getUserID
    };

    printData("HEADERS: $headers");
    try {
      final response = await http.get(urlForPost, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    printData(responseJson);
    return responseJson;
  }

  // }

  // Future<dynamic> postAllCallNonParam({required String url}) async {
  //   printData("Calling API: $url");
  //
  //   Uri urlForPost = Uri.parse("${Endpoints.BASE_URL}$url");
  //   var responseJson;
  //   try {
  //     final response =
  //         await http.post(urlForPost, headers: {'Authorization': 'Bearer '});
  //     responseJson = _response(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //
  //   printData(responseJson);
  //   return responseJson;
  // }

  Future<dynamic> postAPICallBusiness(
      {required String endPoint, required var param}) async {
    Uri urlForPost = Uri.parse("${Endpoints.BASE_URL}$endPoint");

    printData("Calling API: $urlForPost");

    printData("Calling parameters: $param");
    var responseJson;
    String currentDate = "";
    currentDate = getDate();
    try {
      final response = await http.post(urlForPost,
          headers: {
            'X-App-Name': '1.0.0.0',
            'X-App-Version': '10000',
            'OS-Version': '24',
            'Authorization': 'Bearer token',
            'X-Date': currentDate,
            'Content-type': 'application/json',
            'X-Store-ID': '8',
            'X-Platform': "DRIVER_APP",
            'X-User-ID': '1'
          },
          body: jsonEncode(param));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Error catch (e) {
      printData('Error: $e');
    }

    printData(responseJson);
    return responseJson;
  }

  Future<dynamic> updateToken({required String endPoint}) async {
    String newBaseURL = storage.read(SharedPrefrencesKeys.BASE_URL_KEY);

    printData("NEW BASE URL ${newBaseURL.toString()}");

    Uri urlForPost = Uri.parse("$newBaseURL$endPoint");
    var responseJson;
    String refreshToken = "";
    String getUserID = "";
    String currentDate = "";
    currentDate = getDate();
    refreshToken = storage.read(SharedPrefrencesKeys.REFRESH_TOKEN_KEY);
    getUserID = storage.read(SharedPrefrencesKeys.USER_ID_KEY);

    printData("URL For Get is: $urlForPost");

    var headers = {
      'X-App-Name': '1.0.0.0',
      'X-App-Version': '10000',
      'OS-Version': '24',
      'Authorization': 'Bearer $refreshToken',
      'X-Date': currentDate,
      'Content-type': 'application/json',
      'X-Store-ID': "8",
      'X-Platform': "DRIVER_APP",
      'X-User-ID': getUserID
    };

    printData("HEADERS: $headers");
    try {
      final response = await http.get(urlForPost, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    printData(responseJson);
    return responseJson;
  }

  Future<dynamic> postAPICall(
      {required String endPoint, required var request}) async {
    String newBaseURL = storage.read(SharedPrefrencesKeys.BASE_URL_KEY);

    Uri urlForPost = Uri.parse("$newBaseURL$endPoint");

    printData("Calling API: $urlForPost");

    printData("Calling Request: $request");

    String getToken = "";
    String getUserID = "";
    String currentDate = "";
    currentDate = getDate();
    getToken = storage.read(SharedPrefrencesKeys.ACCESS_TOKEN_KEY) ?? "";
    getUserID = storage.read(SharedPrefrencesKeys.USER_ID_KEY) ?? "";
    printData("URL For Get is: $urlForPost");

    var headers = {
      'X-App-Name': '1.0.0.0',
      'X-App-Version': '10000',
      'OS-Version': '24',
      'Authorization': 'Bearer $getToken',
      'X-Date': currentDate,
      'Content-type': 'application/json',
      'X-Store-ID': "8",
      'X-Platform': "DRIVER_APP",
      'X-User-ID': getUserID
    };
    var responseJson;

    printData("HEADERS: $headers");

    try {
      final response = await http.post(urlForPost,
          headers: headers, body: jsonEncode(request));
      printData(response);
      responseJson = _response(response);
    } on SocketException {
      Get.back();
      showSnackBar("","Internet not available");
      throw FetchDataException('No Internet connection');

    } on Error catch (e) {
      printData('Error: $e');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    printData(response.statusCode);

    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 403:
        // showSnackBar(response.statusCode);
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
      // showSnackBar(response.statusCode);
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }



  void showSnackBar(statusCode,message) {
    Get.snackbar(
      "Turns Fleets",
      "${message??"Something went wrong Status Code"} : $statusCode",
      snackPosition: SnackPosition.TOP,
    );
  }

  void printData(responseData) {
    if (kDebugMode) {
      print(responseData);
    }
  }
}
