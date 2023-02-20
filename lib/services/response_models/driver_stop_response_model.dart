class DriverStopsResponseModel {
  bool? status;
  String? message;
  String? routeName;
  String? routeTimingFrom;
  String? routeTimingTo;
  String? distance;
  String? totalStop;
  List<DriverStopListData> data = [];
  String? meta;
  String? validationError;

  DriverStopsResponseModel(
      {this.status,
        this.message,
        this.routeName,
        this.routeTimingFrom,
        this.routeTimingTo,
        this.distance,
        this.totalStop,
       required this.data ,
        this.meta,
        this.validationError});

  DriverStopsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    routeName = json['Route_name'];
    routeTimingFrom = json['Route_Timing_From'];
    routeTimingTo = json['Route_Timing_To'];
    distance = json['Distance'];
    totalStop = json['TotalStop'];
    if (json['data'] != null) {
      data = <DriverStopListData>[];
      json['data'].forEach((v) {
        data.add(DriverStopListData.fromJson(v));
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
    data['Route_name'] = routeName;
    data['Route_Timing_From'] = routeTimingFrom;
    data['Route_Timing_To'] = routeTimingTo;
    data['Distance'] = distance;
    data['TotalStop'] = totalStop;
    if (this.data.isNotEmpty) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    } else{
      data['data'] = [];
    }
    data['meta'] = meta;
    data['validation_error'] = validationError;
    return data;
  }
}

class DriverStopListData {
  String? stopId;
  String? stop;
  String? invoiceNo;
  String? status;
  String? stopStatus;
  String? estTime;
  String? userLat;
  String? userLng;
  String? stopNotes;

  DriverStopListData(
      {this.stopId,
        this.stop,
        this.invoiceNo,
        this.status,
        this.stopStatus,
        this.estTime,
        this.userLat,
        this.userLng,
        this.stopNotes});

  DriverStopListData.fromJson(Map<String, dynamic> json) {
    stopId = json['stop_id'];
    stop = json['Stop'];
    invoiceNo = json['InvoiceNo'];
    status = json['Status'];
    stopStatus = json['stop_status'];
    estTime = json['est_time'];
    userLat = json['user_lat'];
    userLng = json['user_lng'];
    stopNotes = json['stop_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stop_id'] = stopId;
    data['Stop'] = stop;
    data['InvoiceNo'] = invoiceNo;
    data['Status'] = status;
    data['stop_status'] = stopStatus;
    data['est_time'] = estTime;
    data['user_lat'] = userLat;
    data['user_lng'] = userLng;
    data['stop_notes'] = stopNotes;
    return data;
  }
}
