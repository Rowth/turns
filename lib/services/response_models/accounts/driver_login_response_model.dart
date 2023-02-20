class DriverLoginResponseModel {
  bool? status;
  String? message;
  Data? data;
  String? meta;
  String? validationError;

  DriverLoginResponseModel(
      {status, message, data, meta, validationError});

  DriverLoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    meta = json['meta'];
    validationError = json['validation_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data!.toJson();
    data['meta'] = meta;
    data['validation_error'] = validationError;
    return data;
  }
}

class Data {
  String? refreshToken;
  String? accessToken;
  EmployeeData? employeeData;

  Data({refreshToken, accessToken, employeeData});

  Data.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refresh_token'];
    accessToken = json['access_token'];
    employeeData = json['employee_data'] != null
        ?  EmployeeData.fromJson(json['employee_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['refresh_token'] = refreshToken;
    data['access_token'] = accessToken;
    if (employeeData != null) {
      data['employee_data'] = employeeData!.toJson();
    }
    return data;
  }
}

class EmployeeData {
  String? userId;
  String? joinDate;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? countryPrefixCode;
  String? mobile;
  String? emailId;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? birthDate;
  String? gender;
  String? designation;
  String? empPin;

  EmployeeData(
      {userId,
        joinDate,
        firstName,
        lastName,
        countryCode,
        countryPrefixCode,
        mobile,
        emailId,
        address1,
        address2,
        city,
        state,
        zip,
        birthDate,
        gender,
        designation,
        empPin});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    joinDate = json['join_date'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    countryPrefixCode = json['country_prefix_code'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    designation = json['designation'];
    empPin = json['emp_pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['user_id'] = userId;
    data['join_date'] = joinDate;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['country_code'] = countryCode;
    data['country_prefix_code'] = countryPrefixCode;
    data['mobile'] = mobile;
    data['email_id'] = emailId;
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['birth_date'] = birthDate;
    data['gender'] = gender;
    data['designation'] = designation;
    data['emp_pin'] = empPin;
    return data;
  }
}
