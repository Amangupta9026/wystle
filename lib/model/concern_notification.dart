class ConcernNotificationModel {
  String? status;
  String? message;
  List<ConcernNotifDetail>? concernNotifDetail;
  String? responsecode;

  ConcernNotificationModel(
      {this.status, this.message, this.concernNotifDetail, this.responsecode});

  ConcernNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['concern_notif_detail'] != null) {
      concernNotifDetail = <ConcernNotifDetail>[];
      json['concern_notif_detail'].forEach((v) {
        concernNotifDetail!.add(ConcernNotifDetail.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (concernNotifDetail != null) {
      data['concern_notif_detail'] =
          concernNotifDetail!.map((v) => v.toJson()).toList();
    }
    data['responsecode'] = responsecode;
    return data;
  }
}

class ConcernNotifDetail {
  int? id;
  String? countryid;
  String? countryName;
  String? stateid;
  String? stateName;
  String? districtid;
  String? districtName;
  String? cityid;
  String? cityName;
  String? conNotifLabel;
  String? conNotifContent;
  String? conNotifUrl;
  String? conNotifPdf;
  String? conNotifBgColor;

  ConcernNotifDetail(
      {this.id,
      this.countryid,
      this.countryName,
      this.stateid,
      this.stateName,
      this.districtid,
      this.districtName,
      this.cityid,
      this.cityName,
      this.conNotifLabel,
      this.conNotifContent,
      this.conNotifUrl,
      this.conNotifPdf,
      this.conNotifBgColor});

  ConcernNotifDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryid = json['countryid'];
    countryName = json['country_name'];
    stateid = json['stateid'];
    stateName = json['state_name'];
    districtid = json['districtid'];
    districtName = json['district_name'];
    cityid = json['cityid'];
    cityName = json['city_name'];
    conNotifLabel = json['con_notif_label'];
    conNotifContent = json['con_notif_content'];
    conNotifUrl = json['con_notif_url'];
    conNotifPdf = json['con_notif_pdf'];
    conNotifBgColor = json['con_notif_bg_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryid'] = countryid;
    data['country_name'] = countryName;
    data['stateid'] = stateid;
    data['state_name'] = stateName;
    data['districtid'] = districtid;
    data['district_name'] = districtName;
    data['cityid'] = cityid;
    data['city_name'] = cityName;
    data['con_notif_label'] = conNotifLabel;
    data['con_notif_content'] = conNotifContent;
    data['con_notif_url'] = conNotifUrl;
    data['con_notif_pdf'] = conNotifPdf;
    data['con_notif_bg_color'] = conNotifBgColor;
    return data;
  }
}
