class LoginCookiesModel {
  String? status;
  String? message;
  String? responsecode;
  String? datetimestamp;

  LoginCookiesModel(
      {this.status, this.message, this.responsecode, this.datetimestamp});

  LoginCookiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    responsecode = json['responsecode'];
    datetimestamp = json['datetimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['responsecode'] = responsecode;
    data['datetimestamp'] = datetimestamp;
    return data;
  }
}
