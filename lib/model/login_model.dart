class LoginModel {
  String? status;
  String? message;
  String? datetimestamp;
  String? responsecode;
  UserDetail? userDetail;

  LoginModel(
      {this.status,
      this.message,
      this.datetimestamp,
      this.responsecode,
      this.userDetail});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    datetimestamp = json['datetimestamp'];
    responsecode = json['responsecode'];
    userDetail = json['user_detail'] != null
        ? UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['datetimestamp'] = datetimestamp;
    data['responsecode'] = responsecode;
    if (userDetail != null) {
      data['user_detail'] = userDetail!.toJson();
    }
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
