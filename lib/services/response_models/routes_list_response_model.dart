class RouteListResponseModel {
  bool? status;
  String? message;
  List<RouteListData> data=[];
  String? meta;
  String? validationError;

  RouteListResponseModel(
      {this.status, this.message, required this.data , this.meta, this.validationError});

  RouteListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RouteListData>[];
      json['data'].forEach((v) {
        data.add(RouteListData.fromJson(v));
      });
    } else{
      json['data'] = [];
    }
    meta = json['meta'];
    validationError = json['validation_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data.isNotEmpty) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['meta'] = meta;
    data['validation_error'] = validationError;
    return data;
  }
}

class RouteListData {
  String? routeId;
  String? routeName;
  String? routeTimingFrom;
  String? routeTimingTo;
  String? routeType;
  String? routeFee;
  String? routeFor;
  String? driverId;
  String? storeId;
  String? routeForMobile;
  String? turnAroundTime;
  String? offSetTime;
  String? routeDescription;
  String? routeDate;
  String? currentRoute;
  String? routeStatus;
  String? totalStop;
  String? totalBag;
  String? totalPieces;
  String? totalWeights;

  RouteListData(
      {this.routeId,
      this.routeName,
      this.routeTimingFrom,
      this.routeTimingTo,
      this.routeType,
      this.routeFee,
      this.routeFor,
      this.driverId,
      this.storeId,
      this.routeForMobile,
      this.turnAroundTime,
      this.offSetTime,
      this.routeDescription,
      this.routeDate,
      this.currentRoute,
      this.routeStatus,
      this.totalStop,
      this.totalBag,
      this.totalPieces,
      this.totalWeights});

  RouteListData.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    routeName = json['route_name'];
    routeTimingFrom = json['route_timing_from'];
    routeTimingTo = json['route_timing_to'];
    routeType = json['route_type'];
    routeFee = json['route_fee'];
    routeFor = json['route_for'];
    driverId = json['driver_id'];
    storeId = json['store_id'];
    routeForMobile = json['route_for_mobile'];
    turnAroundTime = json['turn_around_time'];
    offSetTime = json['off_set_time'];
    routeDescription = json['route_description'];
    routeDate = json['route_date'];
    currentRoute = json['current_route'];
    routeStatus = json['route_status'];
    totalStop = json['total_stop'];
    totalBag = json['total_bag'];
    totalPieces = json['total_pieces'];
    totalWeights = json['total_weights'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['route_id'] = routeId;
    data['route_name'] = routeName;
    data['route_timing_from'] = routeTimingFrom;
    data['route_timing_to'] = routeTimingTo;
    data['route_type'] = routeType;
    data['route_fee'] = routeFee;
    data['route_for'] = routeFor;
    data['driver_id'] = driverId;
    data['store_id'] = storeId;
    data['route_for_mobile'] = routeForMobile;
    data['turn_around_time'] = turnAroundTime;
    data['off_set_time'] = offSetTime;
    data['route_description'] = routeDescription;
    data['route_date'] = routeDate;
    data['current_route'] = currentRoute;
    data['route_status'] = routeStatus;
    data['total_stop'] = totalStop;
    data['total_bag'] = totalBag;
    data['total_pieces'] = totalPieces;
    data['total_weights'] = totalWeights;
    return data;
  }
}
