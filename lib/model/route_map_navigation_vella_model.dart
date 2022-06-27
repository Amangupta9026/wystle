// To parse this JSON data, do
//
//     final routeNavigationModel = routeNavigationModelFromJson(jsonString);

import 'dart:convert';

RouteNavigationModel routeNavigationModelFromJson(String str) =>
    RouteNavigationModel.fromJson(json.decode(str));

String routeNavigationModelToJson(RouteNavigationModel data) =>
    json.encode(data.toJson());

class RouteNavigationModel {
  RouteNavigationModel({
    this.trip,
  });

  Trip ? trip;

  factory RouteNavigationModel.fromJson(Map<String, dynamic> json) =>
      RouteNavigationModel(
        trip: Trip.fromJson(json["trip"]),
      );

  Map<String, dynamic> toJson() => {
        "trip": trip?.toJson(),
      };
}

class Trip {
  Trip({
    this.locations,
    this.legs,
    this.summary,
    this.statusMessage,
    this.status,
    this.units,
    this.language,
  });

  List<Location>? locations;
  List<Leg>? legs;
  Summary ? summary;
  String? statusMessage;
  int? status;
  String ?units;
  String ?language;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
        statusMessage: json["status_message"],
        status: json["status"],
        units: json["units"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
        "legs": List<dynamic>.from(legs!.map((x) => x.toJson())),
        "summary": summary!.toJson(),
        "status_message": statusMessage,
        "status": status,
        "units": units,
        "language": language,
      };
}

class Leg {
  Leg({
    this.maneuvers,
    this.summary,
    this.shape,
  });

  List<Maneuver>? maneuvers;
  Summary? summary;
  String ?shape;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        maneuvers: List<Maneuver>.from(
            json["maneuvers"].map((x) => Maneuver.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
        shape: json["shape"],
      );

  Map<String, dynamic> toJson() => {
        "maneuvers": List<dynamic>.from(maneuvers!.map((x) => x.toJson())),
        "summary": summary!.toJson(),
        "shape": shape,
      };
}

class Maneuver {
  Maneuver({
    this.type,
    this.instruction,
    this.verbalSuccinctTransitionInstruction,
    this.verbalPreTransitionInstruction,
    this.verbalPostTransitionInstruction,
    this.streetNames,
    this.time,
    this.length,
    this.cost,
    this.beginShapeIndex,
    this.endShapeIndex,
    this.verbalMultiCue,
    this.travelMode,
    this.travelType,
    this.verbalTransitionAlertInstruction,
    this.hasTimeRestrictions,
    this.beginStreetNames,
  });

  int ?type;
  String? instruction;
  String ?verbalSuccinctTransitionInstruction;
  String ?verbalPreTransitionInstruction;
  String ?verbalPostTransitionInstruction;
  List<String>? streetNames;
  double? time;
  double? length;
  double? cost;
  int ?beginShapeIndex;
  int ?endShapeIndex;
  bool? verbalMultiCue;
  String? travelMode;
  String? travelType;
  String? verbalTransitionAlertInstruction;
  bool ?hasTimeRestrictions;
  List<String>? beginStreetNames;

  factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        type: json["type"],
        instruction: json["instruction"],
        verbalSuccinctTransitionInstruction:
            json["verbal_succinct_transition_instruction"],
        verbalPreTransitionInstruction:
            json["verbal_pre_transition_instruction"],
        verbalPostTransitionInstruction:
            json["verbal_post_transition_instruction"],
        streetNames: json["street_names"] == null
            ? null
            : List<String>.from(json["street_names"].map((x) => x)),
        time: json["time"].toDouble(),
        length: json["length"].toDouble(),
        cost: json["cost"].toDouble(),
        beginShapeIndex: json["begin_shape_index"],
        endShapeIndex: json["end_shape_index"],
        verbalMultiCue:
            json["verbal_multi_cue"],
        travelMode: json["travel_mode"],
        travelType: json["travel_type"],
        verbalTransitionAlertInstruction:
            json["verbal_transition_alert_instruction"],
        hasTimeRestrictions: json["has_time_restrictions"],
        beginStreetNames: json["begin_street_names"] == null
            ? null
            : List<String>.from(json["begin_street_names"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "instruction": instruction,
        "verbal_succinct_transition_instruction":
            verbalSuccinctTransitionInstruction,
        "verbal_pre_transition_instruction": verbalPreTransitionInstruction,
        "verbal_post_transition_instruction":
            verbalPostTransitionInstruction,
        "street_names": streetNames == null
            ? null
            : List<dynamic>.from(streetNames!.map((x) => x)),
        "time": time,
        "length": length,
        "cost": cost,
        "begin_shape_index": beginShapeIndex,
        "end_shape_index": endShapeIndex,
        "verbal_multi_cue": verbalMultiCue,
        "travel_mode": travelMode,
        "travel_type": travelType,
        "verbal_transition_alert_instruction":
            verbalTransitionAlertInstruction,
        "has_time_restrictions":
            hasTimeRestrictions,
        "begin_street_names": beginStreetNames == null
            ? null
            : List<dynamic>.from(beginStreetNames!.map((x) => x)),
      };
}

class Summary {
  Summary({
    this.hasTimeRestrictions,
    this.minLat,
    this.minLon,
    this.maxLat,
    this.maxLon,
    this.time,
    this.length,
    this.cost,
  });

  bool? hasTimeRestrictions;
  double? minLat;
  double? minLon;
  double? maxLat;
  double? maxLon;
  double? time;
  double? length;
  double? cost;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        hasTimeRestrictions: json["has_time_restrictions"],
        minLat: json["min_lat"].toDouble(),
        minLon: json["min_lon"].toDouble(),
        maxLat: json["max_lat"].toDouble(),
        maxLon: json["max_lon"].toDouble(),
        time: json["time"].toDouble(),
        length: json["length"].toDouble(),
        cost: json["cost"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "has_time_restrictions": hasTimeRestrictions,
        "min_lat": minLat,
        "min_lon": minLon,
        "max_lat": maxLat,
        "max_lon": maxLon,
        "time": time,
        "length": length,
        "cost": cost,
      };
}

class Location {
  Location({
    this.type,
    this.lat,
    this.lon,
    this.sideOfStreet,
    this.originalIndex,
  });

  String ?type;
  double ?lat;
  double ?lon;
  String ?sideOfStreet;
  int ?originalIndex;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        sideOfStreet: json["side_of_street"],
        originalIndex: json["original_index"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "lat": lat,
        "lon": lon,
        "side_of_street": sideOfStreet,
        "original_index": originalIndex,
      };
}
