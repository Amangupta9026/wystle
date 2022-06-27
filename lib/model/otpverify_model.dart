class OTPVerifyModel {
  String? status;
  String? message;
  int? otpNumber;
  String? registerFlag;
  String? datetimestamp;
  String? responsecode;

  OTPVerifyModel(
      {this.status,
      this.message,
      this.otpNumber,
      this.registerFlag,
      this.datetimestamp,
      this.responsecode});

  OTPVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otpNumber = json['otp_number'];
    registerFlag = json['register_flag'];
    datetimestamp = json['datetimestamp'];
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['otp_number'] = otpNumber;
    data['register_flag'] = registerFlag;
    data['datetimestamp'] = datetimestamp;
    data['responsecode'] = responsecode;
    return data;
  }
}
