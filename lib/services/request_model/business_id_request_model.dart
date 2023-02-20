class BusinessIDRequestModel {
  String? businessName;

  BusinessIDRequestModel({this.businessName});

  BusinessIDRequestModel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    return data;
  }


}