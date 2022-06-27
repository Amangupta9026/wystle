class EmailVerifiedSuccessModel {
  String? status;
  String? message;
  String? datetimestamp;
  String? responsecode;

  EmailVerifiedSuccessModel(
      {this.status, this.message, this.datetimestamp, this.responsecode});

  EmailVerifiedSuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    datetimestamp = json['datetimestamp'];
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['datetimestamp'] = datetimestamp;
    data['responsecode'] = responsecode;
    return data;
  }
}
