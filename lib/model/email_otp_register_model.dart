class EmailOTPRegisterModel {
  String? status;
  String? message;
  UserDetail? userDetail;
  String? datetimestamp;
  String? responsecode;

  EmailOTPRegisterModel(
      {this.status,
      this.message,
      this.userDetail,
      this.datetimestamp,
      this.responsecode});

  EmailOTPRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userDetail = json['user_detail'] != null
        ? UserDetail.fromJson(json['user_detail'])
        : null;
    datetimestamp = json['datetimestamp'];
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (userDetail != null) {
      data['user_detail'] = userDetail!.toJson();
    }
    data['datetimestamp'] = datetimestamp;
    data['responsecode'] = responsecode;
    return data;
  }
}

class UserDetail {
  int? userid;
  String? firstname;
  String? lastname;
  String? email;
  String? mobileno;
  String? emailverifytag;
  String? status;
  String? authToken;

  UserDetail(
      {this.userid,
      this.firstname,
      this.lastname,
      this.email,
      this.mobileno,
      this.emailverifytag,
      this.status,
      this.authToken});

  UserDetail.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    mobileno = json['mobileno'];
    emailverifytag = json['emailverifytag'];
    status = json['status'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['mobileno'] = mobileno;
    data['emailverifytag'] = emailverifytag;
    data['status'] = status;
    data['auth_token'] = authToken;
    return data;
  }
}
