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
        loginFlashDetail!.add( LoginFlashDetail.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (loginFlashDetail != null) {
      data['login_flash_detail'] =
          loginFlashDetail!.map((v) => v.toJson()).toList();
    }
    data['responsecode'] = responsecode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['countryid'] = countryid;
    data['country_name'] = countryName;
    data['stateid'] = stateid;
    data['state_name'] = stateName;
    data['cityid'] = cityid;
    data['city_name'] = cityName;
    data['login_flash_image'] = loginFlashImage;
    data['login_flash_label'] = loginFlashLabel;
    data['login_flash_content'] = loginFlashContent;
    data['login_flash_bg_color'] = loginFlashBgColor;
    return data;
  }
}
