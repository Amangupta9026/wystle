class RoutingMapModel {
  String? formatVersion;
  List<Routes>? routes;

  RoutingMapModel({this.formatVersion, this.routes});

  RoutingMapModel.fromJson(Map<String, dynamic> json) {
    formatVersion = json['formatVersion'];
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatVersion'] = formatVersion;
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  Summary? summary;
  List<Legs>? legs;
  List<Sections>? sections;

  Routes({this.summary, this.legs, this.sections});

  Routes.fromJson(Map<String, dynamic> json) {
    summary =
        json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(Legs.fromJson(v));
      });
    }
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (legs != null) {
      data['legs'] = legs!.map((v) => v.toJson()).toList();
    }
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? lengthInMeters;
  int? travelTimeInSeconds;
  int? trafficDelayInSeconds;
  int? trafficLengthInMeters;
  String? departureTime;
  String? arrivalTime;

  Summary(
      {this.lengthInMeters,
      this.travelTimeInSeconds,
      this.trafficDelayInSeconds,
      this.trafficLengthInMeters,
      this.departureTime,
      this.arrivalTime});

  Summary.fromJson(Map<String, dynamic> json) {
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

class Legs {
  Summary? summary;
  List<Points>? points;

  Legs({this.summary, this.points});

  Legs.fromJson(Map<String, dynamic> json) {
    summary =
        json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  double? latitude;
  double? longitude;

  Points({this.latitude, this.longitude});

  Points.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Sections {
  int? startPointIndex;
  int? endPointIndex;
  String? sectionType;
  String? travelMode;

  Sections(
      {this.startPointIndex,
      this.endPointIndex,
      this.sectionType,
      this.travelMode});

  Sections.fromJson(Map<String, dynamic> json) {
    startPointIndex = json['startPointIndex'];
    endPointIndex = json['endPointIndex'];
    sectionType = json['sectionType'];
    travelMode = json['travelMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startPointIndex'] = startPointIndex;
    data['endPointIndex'] = endPointIndex;
    data['sectionType'] = sectionType;
    data['travelMode'] = travelMode;
    return data;
  }
}
