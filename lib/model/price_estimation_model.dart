class PriceEstimationModel {
  String? status;
  String? message;

  ReqDetail? reqDetail;
  PickupDetail? pickupDetail;
  PickupDetail? dropDetail;
  DistanceDetail? distanceDetail;
  SurchargeDetail? surchargeDetail;
  List<PolicyDetail>? policyDetail;
  List<EstimationDetail>? estimationDetail;
  String? responsecode;
  String? datetimestamp;

  PriceEstimationModel(
      {this.status,
      this.message,
      this.reqDetail,
      this.pickupDetail,
      this.dropDetail,
      this.distanceDetail,
      this.surchargeDetail,
      this.policyDetail,
      this.estimationDetail,
      this.responsecode,
      this.datetimestamp});

  PriceEstimationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    reqDetail = json['req_detail'] != null
        ? ReqDetail.fromJson(json['req_detail'])
        : null;
    pickupDetail = json['pickup_detail'] != null
        ? PickupDetail.fromJson(json['pickup_detail'])
        : null;
    dropDetail = json['drop_detail'] != null
        ? PickupDetail.fromJson(json['drop_detail'])
        : null;
    distanceDetail = json['distance_detail'] != null
        ? DistanceDetail.fromJson(json['distance_detail'])
        : null;
    surchargeDetail = json['surcharge_detail'] != null
        ? SurchargeDetail.fromJson(json['surcharge_detail'])
        : null;

    if (json['policy_detail'] != null) {
      policyDetail = <PolicyDetail>[];

      if (json['policy_detail'] is! String) {
        json['policy_detail'].forEach((v) {
          policyDetail!.add(PolicyDetail.fromJson(v));
        });
      }
    }
    // if (json['policy_detail'] != null) {
    //   policyDetail = <PolicyDetail>[];
    //   json['policy_detail'].forEach((v) {
    //     policyDetail!.add(PolicyDetail.fromJson(v));
    //   });
    // }
    if (json['estimation_detail'] != null) {
      estimationDetail = <EstimationDetail>[];
      json['estimation_detail'].forEach((v) {
        estimationDetail!.add(EstimationDetail.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
    datetimestamp = json['datetimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (reqDetail != null) {
      data['req_detail'] = reqDetail!.toJson();
    }
    if (pickupDetail != null) {
      data['pickup_detail'] = pickupDetail!.toJson();
    }
    if (dropDetail != null) {
      data['drop_detail'] = dropDetail!.toJson();
    }
    if (distanceDetail != null) {
      data['distance_detail'] = distanceDetail!.toJson();
    }
    if (surchargeDetail != null) {
      data['surcharge_detail'] = surchargeDetail!.toJson();
    }
    if (policyDetail != null) {
      data['policy_detail'] = policyDetail!.map((v) => v.toJson()).toList();
    }
    if (estimationDetail != null) {
      data['estimation_detail'] =
          estimationDetail!.map((v) => v.toJson()).toList();
    }
    data['responsecode'] = responsecode;
    data['datetimestamp'] = datetimestamp;
    return data;
  }
}

class ReqDetail {
  String? datetime;
  int? month;
  int? weekday;
  String? dayname;
  int? hour;
  int? minute;
  int? minuteSlab;
  double? picklat;
  double? picklong;
  double? droplat;
  double? droplong;

  ReqDetail(
      {this.datetime,
      this.month,
      this.weekday,
      this.dayname,
      this.hour,
      this.minute,
      this.minuteSlab,
      this.picklat,
      this.picklong,
      this.droplat,
      this.droplong});

  ReqDetail.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    month = json['month'];
    weekday = json['weekday'];
    dayname = json['dayname'];
    hour = json['hour'];
    minute = json['minute'];
    minuteSlab = json['minute_slab'];
    picklat = json['picklat'];
    picklong = json['picklong'];
    droplat = json['droplat'];
    droplong = json['droplong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datetime'] = datetime;
    data['month'] = month;
    data['weekday'] = weekday;
    data['dayname'] = dayname;
    data['hour'] = hour;
    data['minute'] = minute;
    data['minute_slab'] = minuteSlab;
    data['picklat'] = picklat;
    data['picklong'] = picklong;
    data['droplat'] = droplat;
    data['droplong'] = droplong;
    return data;
  }
}

class PickupDetail {
  String? countryId;
  String? countryName;
  String? stateId;
  String? stateName;
  String? districtId;
  String? districtName;
  String? cityId;
  String? cityName;
  String? cityPostcode;
  String? areaId;
  String? areaName;
  String? areaPostcode;

  PickupDetail(
      {this.countryId,
      this.countryName,
      this.stateId,
      this.stateName,
      this.districtId,
      this.districtName,
      this.cityId,
      this.cityName,
      this.cityPostcode,
      this.areaId,
      this.areaName,
      this.areaPostcode});

  PickupDetail.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    cityPostcode = json['city_postcode'];
    areaId = json['area_id'];
    areaName = json['area_name'];
    areaPostcode = json['area_postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    data['state_id'] = stateId;
    data['state_name'] = stateName;
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['city_postcode'] = cityPostcode;
    data['area_id'] = areaId;
    data['area_name'] = areaName;
    data['area_postcode'] = areaPostcode;
    return data;
  }
}

class DistanceDetail {
  int? lengthInMeters;
  int? travelTimeInSeconds;
  int? trafficDelayInSeconds;
  int? trafficLengthInMeters;
  String? departureTime;
  String? arrivalTime;

  DistanceDetail(
      {this.lengthInMeters,
      this.travelTimeInSeconds,
      this.trafficDelayInSeconds,
      this.trafficLengthInMeters,
      this.departureTime,
      this.arrivalTime});

  DistanceDetail.fromJson(Map<String, dynamic> json) {
    lengthInMeters = json['lengthInMeters'];
    travelTimeInSeconds = json['travelTimeInSeconds'];
    trafficDelayInSeconds = json['trafficDelayInSeconds'];
    trafficLengthInMeters = json['trafficLengthInMeters'];
    departureTime = json['departureTime'];
    arrivalTime = json['arrivalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lengthInMeters'] = lengthInMeters;
    data['travelTimeInSeconds'] = travelTimeInSeconds;
    data['trafficDelayInSeconds'] = trafficDelayInSeconds;
    data['trafficLengthInMeters'] = trafficLengthInMeters;
    data['departureTime'] = departureTime;
    data['arrivalTime'] = arrivalTime;
    return data;
  }
}

class SurchargeDetail {
  double? standardSurcharge;
  String? weather;
  double? weatherSurchargePercentage;
  double? weatherSurcharge;
  num? policySurchargePercentage;
  num? policySurcharge;
  num? finalSurcharge;

  SurchargeDetail(
      {this.standardSurcharge,
      this.weather,
      this.weatherSurchargePercentage,
      this.weatherSurcharge,
      this.policySurchargePercentage,
      this.policySurcharge,
      this.finalSurcharge});

  SurchargeDetail.fromJson(Map<String, dynamic> json) {
    standardSurcharge = json['standard_surcharge'];
    weather = json['weather'];
    weatherSurchargePercentage = json['weather_surcharge_percentage'];
    weatherSurcharge = json['weather_surcharge'];
    policySurchargePercentage = json['policy_surcharge_percentage'];
    policySurcharge = json['policy_surcharge'];
    finalSurcharge = json['final_surcharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['standard_surcharge'] = standardSurcharge;
    data['weather'] = weather;
    data['weather_surcharge_percentage'] = weatherSurchargePercentage;
    data['weather_surcharge'] = weatherSurcharge;
    data['policy_surcharge_percentage'] = policySurchargePercentage;
    data['policy_surcharge'] = policySurcharge;
    data['final_surcharge'] = finalSurcharge;
    return data;
  }
}

class PolicyDetail {
  int? id;
  String? countryid;
  String? stateid;
  String? districtid;
  String? cityid;
  String? areaid;
  String? fromDate;
  String? toDate;
  int? serviceGroupId;
  String? scpTarget;
  int? polyDsUniqueid;
  String? scpMethod;
  double? scpPercentage;
  double? additionalCharges;

  PolicyDetail(
      {this.id,
      this.countryid,
      this.stateid,
      this.districtid,
      this.cityid,
      this.areaid,
      this.fromDate,
      this.toDate,
      this.serviceGroupId,
      this.scpTarget,
      this.polyDsUniqueid,
      this.scpMethod,
      this.scpPercentage,
      this.additionalCharges});

  PolicyDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryid = json['countryid'];
    stateid = json['stateid'];
    districtid = json['districtid'];
    cityid = json['cityid'];
    areaid = json['areaid'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    serviceGroupId = json['service_group_id'];
    scpTarget = json['scp_target'];
    polyDsUniqueid = json['poly_ds_uniqueid'];
    scpMethod = json['scp_method'];
    scpPercentage = json['scp_percentage'];
    additionalCharges = json['additional_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryid'] = countryid;
    data['stateid'] = stateid;
    data['districtid'] = districtid;
    data['cityid'] = cityid;
    data['areaid'] = areaid;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['service_group_id'] = serviceGroupId;
    data['scp_target'] = scpTarget;
    data['poly_ds_uniqueid'] = polyDsUniqueid;
    data['scp_method'] = scpMethod;
    data['scp_percentage'] = scpPercentage;
    data['additional_charges'] = additionalCharges;
    return data;
  }
}

class EstimationDetail {
  bool isSelected = false;
  int? id;
  String? countryid;
  String? stateid;
  String? districtid;
  String? cityid;
  int? vehicleCategoryId;
  String? vehicleCategoryName;
  String? vehicleTopView;
  String? vehicleSideView;
  int? serviceGroupId;
  double? baseFare;
  double? perMileFare;
  String? fareUnit;
  double? rideTimeFare;
  double? minimumFare;
  double? prerideWaitTimeFare;
  int? prerideWaitTime;
  String? timeUnit;
  double? cancellationFees;
  double? commission;
  double? additionalFee;
  double? estimatedPrice;
  double? kmDistance;
  double? mileDistance;
  double? travelTimeMinute;

  EstimationDetail(
      {this.isSelected = false,
      this.id,
      this.countryid,
      this.stateid,
      this.districtid,
      this.cityid,
      this.vehicleCategoryId,
      this.vehicleCategoryName,
      this.vehicleTopView,
      this.vehicleSideView,
      this.serviceGroupId,
      this.baseFare,
      this.perMileFare,
      this.fareUnit,
      this.rideTimeFare,
      this.minimumFare,
      this.prerideWaitTimeFare,
      this.prerideWaitTime,
      this.timeUnit,
      this.cancellationFees,
      this.commission,
      this.additionalFee,
      this.estimatedPrice,
      this.kmDistance,
      this.mileDistance,
      this.travelTimeMinute});

  EstimationDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryid = json['countryid'];
    stateid = json['stateid'];
    districtid = json['districtid'];
    cityid = json['cityid'];
    vehicleCategoryId = json['vehicle_category_id'];
    vehicleCategoryName = json['vehicle_category_name'];
    vehicleTopView = json['vehicle_top_view'];
    vehicleSideView = json['vehicle_side_view'];
    serviceGroupId = json['service_group_id'];
    baseFare = json['base_fare'];
    perMileFare = json['per_mile_fare'];
    fareUnit = json['fare_unit'];
    rideTimeFare = json['ride_time_fare'];
    minimumFare = json['minimum_fare'];
    prerideWaitTimeFare = json['preride_wait_time_fare'];
    prerideWaitTime = json['preride_wait_time'];
    timeUnit = json['time_unit'];
    cancellationFees = json['cancellation_fees'];
    commission = json['commission'];
    additionalFee = json['additional_fee'];
    estimatedPrice = json['estimated_price'];
    kmDistance = json['km_distance'];
    mileDistance = json['mile_distance'];
    travelTimeMinute = json['travel_time_minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryid'] = countryid;
    data['stateid'] = stateid;
    data['districtid'] = districtid;
    data['cityid'] = cityid;
    data['vehicle_category_id'] = vehicleCategoryId;
    data['vehicle_category_name'] = vehicleCategoryName;
    data['vehicle_top_view'] = vehicleTopView;
    data['vehicle_side_view'] = vehicleSideView;
    data['service_group_id'] = serviceGroupId;
    data['base_fare'] = baseFare;
    data['per_mile_fare'] = perMileFare;
    data['fare_unit'] = fareUnit;
    data['ride_time_fare'] = rideTimeFare;
    data['minimum_fare'] = minimumFare;
    data['preride_wait_time_fare'] = prerideWaitTimeFare;
    data['preride_wait_time'] = prerideWaitTime;
    data['time_unit'] = timeUnit;
    data['cancellation_fees'] = cancellationFees;
    data['commission'] = commission;
    data['additional_fee'] = additionalFee;
    data['estimated_price'] = estimatedPrice;
    data['km_distance'] = kmDistance;
    data['mile_distance'] = mileDistance;
    data['travel_time_minute'] = travelTimeMinute;
    return data;
  }
}
