class SearchModel {
  Summary? summary;
  List<Results>? results;

  SearchModel({this.summary, this.results});

  SearchModel.fromJson(Map<String, dynamic> json) {
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  String? query;
  String? queryType;
  int? queryTime;
  int? numResults;
  int? offset;
  int? totalResults;
  int? fuzzyLevel;
  GeoBias? geoBias;

  Summary(
      {this.query,
      this.queryType,
      this.queryTime,
      this.numResults,
      this.offset,
      this.totalResults,
      this.fuzzyLevel,
      this.geoBias});

  Summary.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    queryType = json['queryType'];
    queryTime = json['queryTime'];
    numResults = json['numResults'];
    offset = json['offset'];
    totalResults = json['totalResults'];
    fuzzyLevel = json['fuzzyLevel'];
    geoBias =
        json['geoBias'] != null ? new GeoBias.fromJson(json['geoBias']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['queryType'] = this.queryType;
    data['queryTime'] = this.queryTime;
    data['numResults'] = this.numResults;
    data['offset'] = this.offset;
    data['totalResults'] = this.totalResults;
    data['fuzzyLevel'] = this.fuzzyLevel;
    if (this.geoBias != null) {
      data['geoBias'] = this.geoBias!.toJson();
    }
    return data;
  }
}

class GeoBias {
  double? lat;
  double? lon;

  GeoBias({this.lat, this.lon});

  GeoBias.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Results {
  String? type;
  String? id;
  double? score;
  double? dist;
  String? info;
  Poi? poi;
  Address? address;
  GeoBias? position;
  Viewport? viewport;
  List<EntryPoints>? entryPoints;
  String? entityType;
  Viewport? boundingBox;
  DataSources? dataSources;

  Results(
      {this.type,
      this.id,
      this.score,
      this.dist,
      this.info,
      this.poi,
      this.address,
      this.position,
      this.viewport,
      this.entryPoints,
      this.entityType,
      this.boundingBox,
      this.dataSources});

  Results.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    score = json['score'];
    dist = json['dist'];
    info = json['info'];
    poi = json['poi'] != null ? new Poi.fromJson(json['poi']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    position = json['position'] != null
        ? new GeoBias.fromJson(json['position'])
        : null;
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
    if (json['entryPoints'] != null) {
      entryPoints = <EntryPoints>[];
      json['entryPoints'].forEach((v) {
        entryPoints!.add(new EntryPoints.fromJson(v));
      });
    }
    entityType = json['entityType'];
    boundingBox = json['boundingBox'] != null
        ? new Viewport.fromJson(json['boundingBox'])
        : null;
    dataSources = json['dataSources'] != null
        ? new DataSources.fromJson(json['dataSources'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['score'] = this.score;
    data['dist'] = this.dist;
    data['info'] = this.info;
    if (this.poi != null) {
      data['poi'] = this.poi!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    if (this.entryPoints != null) {
      data['entryPoints'] = this.entryPoints!.map((v) => v.toJson()).toList();
    }
    data['entityType'] = this.entityType;
    if (this.boundingBox != null) {
      data['boundingBox'] = this.boundingBox!.toJson();
    }
    if (this.dataSources != null) {
      data['dataSources'] = this.dataSources!.toJson();
    }
    return data;
  }
}

class Poi {
  String? name;
  String? phone;
  List<CategorySet>? categorySet;
  List<String>? categories;
  List<Classifications>? classifications;

  Poi(
      {this.name,
      this.phone,
      this.categorySet,
      this.categories,
      this.classifications});

  Poi.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    if (json['categorySet'] != null) {
      categorySet = <CategorySet>[];
      json['categorySet'].forEach((v) {
        categorySet!.add(new CategorySet.fromJson(v));
      });
    }
    categories = json['categories'].cast<String>();
    if (json['classifications'] != null) {
      classifications = <Classifications>[];
      json['classifications'].forEach((v) {
        classifications!.add(new Classifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    if (this.categorySet != null) {
      data['categorySet'] = this.categorySet!.map((v) => v.toJson()).toList();
    }
    data['categories'] = this.categories;
    if (this.classifications != null) {
      data['classifications'] =
          this.classifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategorySet {
  int? id;

  CategorySet({this.id});

  CategorySet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Classifications {
  String? code;
  List<Names>? names;

  Classifications({this.code, this.names});

  Classifications.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) {
        names!.add(new Names.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.names != null) {
      data['names'] = this.names!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Names {
  String? nameLocale;
  String? name;

  Names({this.nameLocale, this.name});

  Names.fromJson(Map<String, dynamic> json) {
    nameLocale = json['nameLocale'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameLocale'] = this.nameLocale;
    data['name'] = this.name;
    return data;
  }
}

class Address {
  String? streetName;
  String? municipalitySubdivision;
  String? municipality;
  String? countrySecondarySubdivision;
  String? countrySubdivision;
  String? postalCode;
  String? countryCode;
  String? country;
  String? countryCodeISO3;
  String? freeformAddress;
  String? localName;

  Address(
      {this.streetName,
      this.municipalitySubdivision,
      this.municipality,
      this.countrySecondarySubdivision,
      this.countrySubdivision,
      this.postalCode,
      this.countryCode,
      this.country,
      this.countryCodeISO3,
      this.freeformAddress,
      this.localName});

  Address.fromJson(Map<String, dynamic> json) {
    streetName = json['streetName'];
    municipalitySubdivision = json['municipalitySubdivision'];
    municipality = json['municipality'];
    countrySecondarySubdivision = json['countrySecondarySubdivision'];
    countrySubdivision = json['countrySubdivision'];
    postalCode = json['postalCode'];
    countryCode = json['countryCode'];
    country = json['country'];
    countryCodeISO3 = json['countryCodeISO3'];
    freeformAddress = json['freeformAddress'];
    localName = json['localName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetName'] = this.streetName;
    data['municipalitySubdivision'] = this.municipalitySubdivision;
    data['municipality'] = this.municipality;
    data['countrySecondarySubdivision'] = this.countrySecondarySubdivision;
    data['countrySubdivision'] = this.countrySubdivision;
    data['postalCode'] = this.postalCode;
    data['countryCode'] = this.countryCode;
    data['country'] = this.country;
    data['countryCodeISO3'] = this.countryCodeISO3;
    data['freeformAddress'] = this.freeformAddress;
    data['localName'] = this.localName;
    return data;
  }
}

class Viewport {
  GeoBias? topLeftPoint;
  GeoBias? btmRightPoint;

  Viewport({this.topLeftPoint, this.btmRightPoint});

  Viewport.fromJson(Map<String, dynamic> json) {
    topLeftPoint = json['topLeftPoint'] != null
        ? new GeoBias.fromJson(json['topLeftPoint'])
        : null;
    btmRightPoint = json['btmRightPoint'] != null
        ? new GeoBias.fromJson(json['btmRightPoint'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topLeftPoint != null) {
      data['topLeftPoint'] = this.topLeftPoint!.toJson();
    }
    if (this.btmRightPoint != null) {
      data['btmRightPoint'] = this.btmRightPoint!.toJson();
    }
    return data;
  }
}

class EntryPoints {
  String? type;
  GeoBias? position;

  EntryPoints({this.type, this.position});

  EntryPoints.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    position = json['position'] != null
        ? new GeoBias.fromJson(json['position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    return data;
  }
}

class DataSources {
  Geometry? geometry;

  DataSources({this.geometry});

  DataSources.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    return data;
  }
}

class Geometry {
  String? id;

  Geometry({this.id});

  Geometry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
