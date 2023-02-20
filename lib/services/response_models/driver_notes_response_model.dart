class DriverNotesResponseModel {
  bool? status;
  String? message;
  String? data;
  String? meta;
  String? validationError;

  DriverNotesResponseModel(
      {this.status, this.message, this.data, this.meta, this.validationError});

  DriverNotesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    message = json['message'] ?? "Something went wrong";
    data = json['data'] ?? "";
    meta = json['meta'] ?? "";
    validationError = json['validation_error'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    data['meta'] = meta;
    data['validation_error'] = validationError;
    return data;
  }
}
