class LoginFlashModel {
  String? status;
  String? message;
  List<LoginFlashDetail>? loginFlashDetail;
  String? responsecode;

  LoginFlashModel(
      {this.status, this.message, this.loginFlashDetail, this.responsecode});

  LoginFlashModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['login_flash_detail'] != null) {
      loginFlashDetail = <LoginFlashDetail>[];
      json['login_flash_detail'].forEach((v) {
        loginFlashDetail!.add(new LoginFlashDetail.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.loginFlashDetail != null) {
      data['login_flash_detail'] =
          this.loginFlashDetail!.map((v) => v.toJson()).toList();
    }
    data['responsecode'] = this.responsecode;
    return data;
  }
}

class LoginFlashDetail {
  int? id;
  String? fromDate;
  String? toDate;
  String? countryid;
  String? countryName;
  String? stateid;
  String? stateName;
  String? cityid;
  String? cityName;
  String? loginFlashImage;
  String? loginFlashLabel;
  String? loginFlashContent;
  String? loginFlashBgColor;

  LoginFlashDetail(
      {this.id,
      this.fromDate,
      this.toDate,
      this.countryid,
      this.countryName,
      this.stateid,
      this.stateName,
      this.cityid,
      this.cityName,
      this.loginFlashImage,
      this.loginFlashLabel,
      this.loginFlashContent,
      this.loginFlashBgColor});

  LoginFlashDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    countryid = json['countryid'];
    countryName = json['country_name'];
    stateid = json['stateid'];
    stateName = json['state_name'];
    cityid = json['cityid'];
    cityName = json['city_name'];
    loginFlashImage = json['login_flash_image'];
    loginFlashLabel = json['login_flash_label'];
    loginFlashContent = json['login_flash_content'];
    loginFlashBgColor = json['login_flash_bg_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['countryid'] = this.countryid;
    data['country_name'] = this.countryName;
    data['stateid'] = this.stateid;
    data['state_name'] = this.stateName;
    data['cityid'] = this.cityid;
    data['city_name'] = this.cityName;
    data['login_flash_image'] = this.loginFlashImage;
    data['login_flash_label'] = this.loginFlashLabel;
    data['login_flash_content'] = this.loginFlashContent;
    data['login_flash_bg_color'] = this.loginFlashBgColor;
    return data;
  }
}
