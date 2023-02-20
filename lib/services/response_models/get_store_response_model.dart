class GetStoresResponseModel {
  bool? status;
  String message="";
  List<StoreResponseData>? data;
  String? meta;
  String? validationError;

  GetStoresResponseModel(
      {this.status, this.message="", this.data, this.meta, this.validationError});

  GetStoresResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? "Token has Expired";
    if (json['data'] != null) {
      data = <StoreResponseData>[];
      json['data'].forEach((v) {
        data!.add(StoreResponseData.fromJson(v));
      });
    }
    meta = json['meta'];
    validationError = json['validation_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['meta'] = meta;
    data['validation_error'] = validationError;
    return data;
  }
}

class StoreResponseData {
  String? id;
  String? storeName;

  StoreResponseData({this.id, this.storeName});

  StoreResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_name'] = storeName;
    return data;
  }
}


