class BusinessIDResponseModel {
  bool? status;
  String? message;
  Data? data;
  String? meta;
  String? validationError;

  BusinessIDResponseModel(
      {this.status, this.message, this.data, this.meta, this.validationError});

  BusinessIDResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['meta'];
    validationError = json['validation_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['meta'] = meta;
    data['validation_error'] = validationError;
    return data;
  }
}

class Data {
  String? countryCode;

  Data({this.countryCode});

  Data.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = countryCode;
    return data;
  }
}
