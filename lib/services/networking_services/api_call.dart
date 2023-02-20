import 'package:driver/services/networking_services/api_manager.dart';
import 'package:driver/services/networking_services/endpoints.dart';
import 'package:driver/services/response_models/complete_route_response_model.dart';
import 'package:driver/services/response_models/driver_notes_response_model.dart';
import 'package:driver/services/response_models/driver_stop_details_response_model.dart';
import 'package:driver/services/response_models/driver_stop_response_model.dart';
import 'package:driver/services/response_models/driver_stop_update_response_model.dart';
import 'package:driver/services/response_models/get_store_response_model.dart';
import 'package:driver/services/response_models/routes_list_response_model.dart';
import 'package:driver/services/response_models/start_route_response_model.dart';

import '../../utils/localization/print_data.dart';
import '../response_models/accounts/business_id_response_model.dart';
import '../response_models/accounts/driver_login_response_model.dart';
import '../response_models/accounts/resend_otp_response_model.dart';
import '../response_models/accounts/send_otp_response_model.dart';
import '../response_models/update_token_response_model.dart';

class CallAPI {
  //API BUSINESS ID
  Future<BusinessIDResponseModel> validateBusiness(
      {required var loginRequestModel}) async {
    BusinessIDResponseModel result = BusinessIDResponseModel();

    try {
      String endPoint = Endpoints.epBusinessLogin;

      var json = await APIManager()
          .postAPICallBusiness(endPoint: endPoint, param: loginRequestModel);

      BusinessIDResponseModel loginModel =
          BusinessIDResponseModel.fromJson(json);
      if (loginModel.status == true) {
        result = loginModel;
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        return result;
      } else {
        result = loginModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

//   Driver Get OTP
  Future<SendOTPResponseModel> sendOTP({required var phoneRequestModel}) async {
    SendOTPResponseModel result = SendOTPResponseModel();

    try {
      String endPoint = Endpoints.epDriverOTP;

      var json = await APIManager()
          .postAPICall(endPoint: endPoint, request: phoneRequestModel);

      SendOTPResponseModel responseModel = SendOTPResponseModel.fromJson(json);
      if (responseModel.status == true) {
        result = responseModel;
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

//   Driver Resend OTP
  Future<ResendOTPResponseModel> resendOTP(
      {required var phoneRequestModel}) async {
    ResendOTPResponseModel result = ResendOTPResponseModel();

    try {
      String endPoint = Endpoints.epDriverResendOTP;

      var json = await APIManager()
          .postAPICall(endPoint: endPoint, request: phoneRequestModel);

      ResendOTPResponseModel responseModel =
          ResendOTPResponseModel.fromJson(json);
      if (responseModel.status == true) {
        result = responseModel;
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

//   Driver LOGIN
  Future<DriverLoginResponseModel> loginDriver(
      {required var loginRequestModel}) async {
    DriverLoginResponseModel result = DriverLoginResponseModel();
    try {
      String endPoint = Endpoints.epDriverLogin;
      var json = await APIManager()
          .postAPICall(endPoint: endPoint, request: loginRequestModel);

      DriverLoginResponseModel responseModel =
          DriverLoginResponseModel.fromJson(json);
      if (responseModel.status == true) {
        result = responseModel;
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<GetStoresResponseModel> getStoresList() async {
    GetStoresResponseModel result = GetStoresResponseModel();

    try {
      String endPoint = Endpoints.epStoreDropdown;

      var json = await APIManager().getAllCall(endPoint: endPoint);

      GetStoresResponseModel responseModel =
          GetStoresResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<RouteListResponseModel> getDriverRouteList(request) async {
    RouteListResponseModel result = RouteListResponseModel(data: []);

    try {
      String endPoint = Endpoints.epDriverRouteList;

      var json =
          await APIManager().postAPICall(endPoint: endPoint, request: request);

      RouteListResponseModel responseModel =
          RouteListResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<DriverStopsResponseModel> getDriverStopsList(request) async {
    DriverStopsResponseModel result = DriverStopsResponseModel(data: []);

    try {
      String endPoint = Endpoints.epDriverStopList;

      var json =
          await APIManager().postAPICall(endPoint: endPoint, request: request);

      DriverStopsResponseModel responseModel =
          DriverStopsResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<DriverStopDetailsResponseModel> driverStopDetails(request) async {
    DriverStopDetailsResponseModel result = DriverStopDetailsResponseModel();

    try {
      String endPoint = Endpoints.epDriverStopDetails;
      var json =
          await APIManager().postAPICall(endPoint: endPoint, request: request);
      DriverStopDetailsResponseModel responseModel =
          DriverStopDetailsResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<UpdateTokenResponseModel> getUpdatedToken() async {
    UpdateTokenResponseModel result = UpdateTokenResponseModel();
    try {
      printData("Token has been expired Hitting Refresh Token API");
      String endPoint = Endpoints.epUpdateToken;
      var json = await APIManager().updateToken(endPoint: endPoint);
      UpdateTokenResponseModel responseModel =
          UpdateTokenResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<DriverNotesResponseModel> addStopNote(request) async {
    DriverNotesResponseModel result = DriverNotesResponseModel();

    try {
      String endPoint = Endpoints.epDriverNotes;
      var json =
          await APIManager().postAPICall(endPoint: endPoint, request: request);
      DriverNotesResponseModel responseModel =
          DriverNotesResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<DriverStopUpdateResponseModel> updateStopStatus(request) async {
    DriverStopUpdateResponseModel result = DriverStopUpdateResponseModel();

    try {
      String endPoint = Endpoints.epDriverUpdateStop;
      var json =
          await APIManager().postAPICall(endPoint: endPoint, request: request);
      DriverStopUpdateResponseModel responseModel =
          DriverStopUpdateResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<StartRouteResponseModel> startRoute(request) async {
    StartRouteResponseModel result = StartRouteResponseModel();

    try {
      String endPoint = Endpoints.epStartRoute;
      var json =
          await APIManager().postAPICall(endPoint: endPoint, request: request);
      StartRouteResponseModel responseModel =
          StartRouteResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<CompleteRouteResponseModel> completeRoute(request) async {
    CompleteRouteResponseModel result = CompleteRouteResponseModel();

    try {
      String endPoint = Endpoints.epCompleteRoute;
      var json =
          await APIManager().postAPICall(endPoint: endPoint, request: request);
      CompleteRouteResponseModel responseModel =
          CompleteRouteResponseModel.fromJson(json);
      if (responseModel.status == true) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }
}
