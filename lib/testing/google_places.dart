import 'dart:developer';

// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart' as geocodinglocation1;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';
import 'package:location_geocoder/location_geocoder.dart';

import '../constant/color_constant.dart';
import '../map/tom_map_riding.dart';

class GoogleSearchPlace extends StatefulWidget {
  final String? yourLocation;
  const GoogleSearchPlace({Key? key, this.yourLocation}) : super(key: key);

  @override
  _GoogleSearchPlaceState createState() => _GoogleSearchPlaceState();
}

class _GoogleSearchPlaceState extends State<GoogleSearchPlace> {
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];
  List<AutocompletePrediction> destinationpredictions = [];
  String? apiKey = 'AIzaSyAqBj9HwZpHsGIspT8FdfyI235ZgDIozIk';
  TextEditingController? sourcefieldTextEditingController =
      TextEditingController();
  TextEditingController? destinationfieldTextEditingController =
      TextEditingController();

  FocusNode? fieldFocusNode;
  bool isSourceSearch = false;

  String? value, destinationSearchValue, getSelectedPlaceValue;

  double? sourceLat, sourceLong;
  double? destinationLat, destinationLong;

  @override
  void initState() {
    super.initState();
    String? apiKey = 'AIzaSyAqBj9HwZpHsGIspT8FdfyI235ZgDIozIk';
    googlePlace = GooglePlace(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_BLACK,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Find a Route',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w300,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onTap: () {
                  setState(() {
                    isSourceSearch = true;
                  });
                },
                controller: sourcefieldTextEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  labelText: "Your Location",
                  labelStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w500,
                      ),
                  hintText: "Enter Source",
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w300,
                      ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.COLOR_BLACK,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.COLOR_BLACK,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && value.length > 3) {
                    autoCompleteSearch(value);

                    // print('Selected: ${value.}');
                  } else {
                    if (predictions.length > 3 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),

              TextField(
                onTap: () {
                  setState(() {
                    isSourceSearch = false;
                  });
                },
                controller: destinationfieldTextEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  labelText: "Search Destination",
                  labelStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w500,
                      ),
                  hintText: 'Enter Destination',
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w300,
                      ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.COLOR_BLACK,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstant.COLOR_BLACK,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (destinationfieldTextEditingController) {
                  if (destinationfieldTextEditingController.isNotEmpty &&
                      destinationfieldTextEditingController.length > 3) {
                    autoDestinationCompleteSearch(
                        destinationfieldTextEditingController);
                  } else {
                    if (destinationpredictions.length > 3 && mounted) {
                      setState(() {
                        destinationpredictions = [];
                      });
                    }
                  }
                },
              ),

              // Source
              isSourceSearch
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: predictions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.pin_drop,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                predictions[index].description.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                              onTap: () async {
                                // debugPrint(destinationfieldTextEditingController?.text);

                                final LocatitonGeocoder geocoder =
                                    LocatitonGeocoder(apiKey.toString());

                                final address = await geocoder
                                    .findAddressesFromQuery(predictions[index]
                                        .description
                                        .toString());

                                setState(() {
                                  sourcefieldTextEditingController?.text =
                                      predictions[index].description.toString();
                                  sourceLat =
                                      address.first.coordinates.latitude;
                                  sourceLong =
                                      address.first.coordinates.longitude;
                                });

                                log(sourceLat.toString());
                                log(sourceLong.toString());

                                debugPrint(predictions[index].placeId);

                                log('sourcelat ${address.first.coordinates.latitude}');
                                log('sourcelong ${address.first.coordinates.longitude}');

                                // List<geocodinglocation1.Location> locations =
                                //     await geocodinglocation1.locationFromAddress(
                                //         predictions[index].description.toString());

                                // log(locations.toString());
                                //
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => SearchLocationMap(
                                //       latitude: address.first.coordinates.latitude,
                                //       longitude: address.first.coordinates.longitude,
                                //     ),
                                //   ),
                                // );

                                predictions.clear();
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: destinationpredictions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              destinationpredictions[index]
                                  .description
                                  .toString(),
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                            onTap: () async {
                              final LocatitonGeocoder geocoder =
                                  LocatitonGeocoder(apiKey.toString());

                              final address1 =
                                  await geocoder.findAddressesFromQuery(
                                      destinationpredictions[index]
                                          .description
                                          .toString());

                              setState(() {
                                destinationfieldTextEditingController?.text =
                                    destinationpredictions[index]
                                        .description
                                        .toString();
                                destinationLat =
                                    address1.first.coordinates.latitude;
                                destinationLong =
                                    address1.first.coordinates.longitude;
                              });

                              debugPrint(
                                  destinationfieldTextEditingController?.text);
                              debugPrint(destinationpredictions[index].placeId);

                              log('destinationlat ${address1.first.coordinates.latitude}');
                              log('destionationlong ${address1.first.coordinates.longitude}');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TomTomMapRiding(
                                    sourceLat: sourceLat,
                                    sourceLong: sourceLong,
                                    destinationLat: destinationLat,
                                    destinationLong: destinationLong,
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(value) async {
    var result = await googlePlace?.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  // Search Destination

  void autoDestinationCompleteSearch(destinationSearchValue) async {
    var result1 = await googlePlace?.autocomplete.get(destinationSearchValue);
    if (result1 != null && result1.predictions != null && mounted) {
      setState(() {
        destinationpredictions = result1.predictions!;
      });
    }
  }

  // BottomSheet for Car Available

}
