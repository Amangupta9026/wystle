class UserLocationModel {
  String? status;
  String? message;
  PredResult? predResult;
  String? responsecode;
  String? datetimestamp;

  UserLocationModel(
      {this.status,
      this.message,
      this.predResult,
      this.responsecode,
      this.datetimestamp});

  UserLocationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    predResult = json['pred_result'] != null
        ? PredResult.fromJson(json['pred_result'])
        : null;
    responsecode = json['responsecode'];
    datetimestamp = json['datetimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (predResult != null) {
      data['pred_result'] = predResult!.toJson();
    }
    data['responsecode'] = responsecode;
    data['datetimestamp'] = datetimestamp;
    return data;
  }
}

class PredResult {
  String? countryId;
  String? countryName;
  String? stateId;
  String? stateName;
  String? cityId;
  String? cityName;
  List<String>? postcodeList;

  PredResult(
      {this.countryId,
      this.countryName,
      this.stateId,
      this.stateName,
      this.cityId,
      this.cityName,
      this.postcodeList});

  PredResult.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    postcodeList = json['postcode_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    data['state_id'] = stateId;
    data['state_name'] = stateName;
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['postcode_list'] = postcodeList;
    return data;
  }
}
