class DriverStopDetailsResponseModel {
  bool? status;
  String? message;
  StopData? stopData;
  String? meta;
  String? validationError;

  DriverStopDetailsResponseModel(
      {this.status,
        this.message,
        this.stopData,
        this.meta,
        this.validationError});

  DriverStopDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status']??false;
    message = json['message']??"Something went wrong";
    stopData = json['stop_data'] != null
        ?  StopData.fromJson(json['stop_data'])
        : StopData();
    meta = json['meta'];
    validationError = json['validation_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (stopData != null) {
      data['stop_data'] = stopData!.toJson();
    }
    data['meta'] = meta;
    data['validation_error'] = validationError;
    return data;
  }
}

class StopData {
  String? stopId;
  String? routeName;
  String? customerName;
  String? customerMobileCode;
  String? customerMobile;
  String? customerAddress;
  String? userLat;
  String? userLng;
  String? distance;
  String? estTime;
  String? totalBag;
  String? pieces;
  String? weights;
  String? stopStatus;
  String? driverNotes;

  StopData(
      {this.stopId,
        this.routeName,
        this.customerName,
        this.customerMobileCode,
        this.customerMobile,
        this.customerAddress,
        this.userLat,
        this.userLng,
        this.distance,
        this.estTime,
        this.totalBag,
        this.pieces,
        this.weights,
        this.stopStatus,
        this.driverNotes});

  StopData.fromJson(Map<String, dynamic> json) {
    stopId = json['stop_id'];
    routeName = json['route_name'];
    customerName = json['customer_name'];
    customerMobileCode = json['customer_mobile_code'];
    customerMobile = json['customer_mobile'];
    customerAddress = json['customer_address'];
    userLat = json['user_lat'];
    userLng = json['user_lng'];
    distance = json['Distance'];
    estTime = json['est_time'];
    totalBag = json['TotalBag'];
    pieces = json['Pieces'];
    weights = json['Weights'];
    stopStatus = json['Stop_Status'];
    driverNotes = json['driver_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stop_id'] = stopId;
    data['route_name'] = routeName;
    data['customer_name'] = customerName;
    data['customer_mobile_code'] = customerMobileCode;
    data['customer_mobile'] = customerMobile;
    data['customer_address'] = customerAddress;
    data['user_lat'] = userLat;
    data['user_lng'] = userLng;
    data['Distance'] = distance;
    data['est_time'] = estTime;
    data['TotalBag'] = totalBag;
    data['Pieces'] = pieces;
    data['Weights'] = weights;
    data['Stop_Status'] = stopStatus;
    data['driver_notes'] = driverNotes;
    return data;
  }
}
