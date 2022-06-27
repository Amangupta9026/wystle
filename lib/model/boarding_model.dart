class BoardingModel {
  String? status;
  String? message;
  List<ObPosterDetail>? obPosterDetail;
  String? responsecode;

  BoardingModel(
      {this.status, this.message, this.obPosterDetail, this.responsecode});

  BoardingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['ob_poster_detail'] != null) {
      obPosterDetail = <ObPosterDetail>[];
      json['ob_poster_detail'].forEach((v) {
        obPosterDetail!.add(ObPosterDetail.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (obPosterDetail != null) {
      data['ob_poster_detail'] =
          obPosterDetail!.map((v) => v.toJson()).toList();
    }
    data['responsecode'] = responsecode;
    return data;
  }
}

class ObPosterDetail {
  int? id;
  String? countryid;
  String? countryName;
  String? stateid;
  String? stateName;
  String? cityid;
  String? cityName;
  String? posterImage;
  String? posterLabel;
  String? posterContent;
  String? posterbgColor;

  ObPosterDetail(
      {this.id,
      this.countryid,
      this.countryName,
      this.stateid,
      this.stateName,
      this.cityid,
      this.cityName,
      this.posterImage,
      this.posterLabel,
      this.posterContent,
      this.posterbgColor});

  ObPosterDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryid = json['countryid'];
    countryName = json['country_name'];
    stateid = json['stateid'];
    stateName = json['state_name'];
    cityid = json['cityid'];
    cityName = json['city_name'];
    posterImage = json['poster_image'];
    posterLabel = json['poster_label'];
    posterContent = json['poster_content'];
    posterbgColor = json['posterbgColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryid'] = countryid;
    data['country_name'] = countryName;
    data['stateid'] = stateid;
    data['state_name'] = stateName;
    data['cityid'] = cityid;
    data['city_name'] = cityName;
    data['poster_image'] = posterImage;
    data['poster_label'] = posterLabel;
    data['poster_content'] = posterContent;
    data['posterbgColor'] = posterbgColor;
    return data;
  }
}
