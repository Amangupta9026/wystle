import 'dart:developer';

// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart' as geocodinglocation1;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';
import 'package:location_geocoder/location_geocoder.dart';

import '../constant/color_constant.dart';
import 'mapapi_testing.dart';

class GoogleSearchPlace extends StatefulWidget {
  final String ? yourLocation;
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

  String? value;
  String? destinationSearchValue;
  String? getSelectedPlaceValue;

  double? sourceLat;
  double? sourceLong;
  double? destinationLat;
  double? destinationLong;

  @override
  void initState() {
    String? apiKey = 'AIzaSyAqBj9HwZpHsGIspT8FdfyI235ZgDIozIk';
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  labelText: "Your Location",
                  labelStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                  hintText: "Enter Source",
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
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
                height: 10,
              ),

              TextField(
                onTap: () {
                  setState(() {
                    isSourceSearch = false;
                  });
                },
                controller: destinationfieldTextEditingController,
                decoration: InputDecoration(
                  labelText: "Search Destination",
                  labelStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                  hintText: 'Enter Destination',
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
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
                      child: ListView.builder(
                        itemCount: predictions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.white,
                              ),
                            ),
                            title:
                                Text(predictions[index].description.toString()),
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
                                sourceLat = address.first.coordinates.latitude;
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
                            title: Text(destinationpredictions[index]
                                .description
                                .toString()),
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

                              // List<geocodinglocation1.Location> locations =
                              //     await geocodinglocation1.locationFromAddress(
                              //         predictions[index].description.toString());

                              // log(locations.toString());
                              //
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TomTomMapApiTesting(
                                    sourceLat: sourceLat,
                                    sourceLong: sourceLong,
                                    destinationLat: destinationLat,
                                    destinationLong: destinationLong,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

              // Container(
              //   margin: const EdgeInsets.only(top: 10, bottom: 10),
              //   child: Image.asset("assets/powered_by_google.png"),
              // ),
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
}

// class DetailsPage extends StatefulWidget {
//   final String? placeId;
//   final GooglePlace? googlePlace;

//   const DetailsPage({Key? key, this.placeId, this.googlePlace})
//       : super(key: key);

//   @override
//   _DetailsPageState createState() =>
//       _DetailsPageState(this.placeId!, this.googlePlace!);
// }

// class _DetailsPageState extends State<DetailsPage> {
//   final String placeId;
//   final GooglePlace googlePlace;

//   _DetailsPageState(this.placeId, this.googlePlace);

//   DetailsResult? detailsResult;
//   List<Uint8List> images = [];

//   @override
//   void initState() {
//     getDetils(this.placeId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Details"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueAccent,
//         onPressed: () {
//           getDetils(this.placeId);
//         },
//         child: const Icon(Icons.refresh),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 250,
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Image.memory(
//                             images[index],
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: ListView(
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: const Text(
//                           "Details",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       detailsResult != null && detailsResult?.types != null
//                           ? Container(
//                               margin: const EdgeInsets.only(left: 15, top: 10),
//                               height: 50,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: detailsResult?.types?.length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: const EdgeInsets.only(right: 10),
//                                     child: Chip(
//                                       label: Text(
//                                         detailsResult!.types![index],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       backgroundColor: Colors.blueAccent,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           : Container(),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.location_on),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult?.formattedAddress != null
//                                 ? 'Address: ${detailsResult?.formattedAddress}'
//                                 : "Address: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: const Icon(Icons.location_searching),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult?.geometry != null &&
//                                     detailsResult?.geometry?.location != null
//                                 ? 'Geometry: ${detailsResult?.geometry?.location?.lat.toString()},${detailsResult?.geometry?.location?.lng.toString()}'
//                                 : "Geometry: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: const Icon(Icons.timelapse),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult?.utcOffset != null
//                                 ? 'UTC offset: ${detailsResult?.utcOffset.toString()} min'
//                                 : "UTC offset: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.rate_review),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult?.rating != null
//                                 ? 'Rating: ${detailsResult?.rating.toString()}'
//                                 : "Rating: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.attach_money),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult?.priceLevel != null
//                                 ? 'Price level: ${detailsResult?.priceLevel.toString()}'
//                                 : "Price level: null",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  // void getDetils(String placeId) async {
  //   var result = await this.googlePlace.details.get(placeId);
  //   if (result != null && result.result != null && mounted) {
  //     setState(() {
  //       detailsResult = result.result;
  //       images = [];
  //     });

  //     if (result.result?.photos != null) {
  //       for (var photo in result.result!.photos!) {
  //         getPhoto(photo.photoReference!);
  //       }
  //     }
  //   }
  // }

  // void getPhoto(String photoReference) async {
  //   var result = await this.googlePlace.photos.get(photoReference, 0, 400);
  //   if (result != null && mounted) {
  //     setState(() {
  //       images.add(result);
  //     });
  //   }
  // }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';

// class GooglePlacesMap extends StatefulWidget {
//   @override
//   _GooglePlacesMapState createState() => _GooglePlacesMapState();
// }

// class _GooglePlacesMapState extends State<GooglePlacesMap> {
//   String googleApikey = "AIzaSyAqBj9HwZpHsGIspT8FdfyI235ZgDIozIk";
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   // LatLng startLocation = LatLng(27.6602292, 85.308027);
//   LatLng startLocation = const LatLng(26.748933, 83.3588367);
//   String location = "Search Location";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Place Search Autocomplete Google Map"),
//           backgroundColor: Colors.deepPurpleAccent,
//         ),
//         body: Stack(children: [
//           //search autoconplete input
//           Positioned(
//               //search input bar
//               top: 10,
//               child: InkWell(
//                   onTap: () async {
//                     var place = await PlacesAutocomplete.show(
//                         context: context,
//                         apiKey: googleApikey,
//                         mode: Mode.overlay,
//                         types: [],
//                         strictbounds: false,
//                         components: [Component(Component.country, 'ind')],
//                         //google_map_webservice package
//                         onError: (err) {
//                           print(err);
//                         });

//                     if (place != null) {
//                       setState(() {
//                         location = place.description.toString();
//                       });

//                       //form google_maps_webservice package
//                       final plist = GoogleMapsPlaces(
//                         apiKey: googleApikey,
//                         apiHeaders: await const GoogleApiHeaders().getHeaders(),
//                         //from google_api_headers package
//                       );
//                       String placeid = place.placeId ?? "0";
//                       final detail = await plist.getDetailsByPlaceId(placeid);
//                       final geometry = detail.result.geometry!;
//                       final lat = geometry.location.lat;
//                       final lang = geometry.location.lng;
//                       var newlatlang = LatLng(lat, lang);

//                       //move map camera to selected place with animation
//                       mapController?.animateCamera(
//                           CameraUpdate.newCameraPosition(
//                               CameraPosition(target: newlatlang, zoom: 17)));
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Card(
//                       child: Container(
//                           padding: const EdgeInsets.all(0),
//                           width: MediaQuery.of(context).size.width - 40,
//                           child: ListTile(
//                             title: Text(
//                               location,
//                               style: const TextStyle(fontSize: 18),
//                             ),
//                             trailing: const Icon(Icons.search),
//                             dense: true,
//                           )),
//                     ),
//                   )))
//         ]));
//   }
// }
