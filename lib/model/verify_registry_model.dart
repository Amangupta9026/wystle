class VerifyRegisterModel {
  String? status;
  String? message;
  String? verificationCode;
  String? datetimestamp;
  String? responsecode;

  VerifyRegisterModel(
      {this.status,
      this.message,
      this.verificationCode,
      this.datetimestamp,
      this.responsecode});

  VerifyRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    verificationCode = json['verification_code'];
    datetimestamp = json['datetimestamp'];
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['verification_code'] = verificationCode;
    data['datetimestamp'] = datetimestamp;
    data['responsecode'] = responsecode;
    return data;
  }
}
