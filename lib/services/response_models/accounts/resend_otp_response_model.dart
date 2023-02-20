class ResendOTPResponseModel {
  bool? status;
  String? message;
  String? data;
  String? meta;
  String? validationError;

  ResendOTPResponseModel(
      {this.status, this.message, this.data, this.meta, this.validationError});

  ResendOTPResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    meta = json['meta'];
    validationError = json['validation_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    data['meta'] = this.meta;
    data['validation_error'] = this.validationError;
    return data;
  }
}
