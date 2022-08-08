// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:typed_data';

// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:geocoding/geocoding.dart' as geocodinglocation1;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:wystle/constant/image_constant.dart';

import '../constant/color_constant.dart';
import '../constant/dio_client.dart';
import '../constant/map_api_key.dart';
import '../map/tom_map_riding.dart';
import '../model/price_estimation_model.dart';
import '../model/routing_map_model.dart';
import '../module/sharedpreference/userdata.dart';
import '../service/api_services.dart';
import '../service/aws_service.dart';

class GoogleSearchPlace extends StatefulWidget {
  final String? yourLocation;
  final String? time;
  const GoogleSearchPlace({Key? key, this.yourLocation, this.time})
      : super(key: key);

  @override
  _GoogleSearchPlaceState createState() => _GoogleSearchPlaceState();
}

class _GoogleSearchPlaceState extends State<GoogleSearchPlace> {
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];
  List<AutocompletePrediction> destinationpredictions = [];
  String? apiKey = googleSearchPlaceApi;
  TextEditingController? sourcefieldTextEditingController =
      TextEditingController();
  TextEditingController? destinationfieldTextEditingController =
      TextEditingController();

  FocusNode? fieldFocusNode;
  bool isSourceSearch = false;

  String? value, destinationSearchValue, getSelectedPlaceValue;

  double? sourceLat, sourceLong;
  double? destinationLat, destinationLong;
  // ignore: prefer_typing_uninitialized_variables
  FocusNode sourceFocusNode = FocusNode();
  FocusNode destinationFocusNode = FocusNode();
  var base64;
  bool isProgressRunning = false;
  RoutingMapModel? routenav;
  var userdata = UserData.geUserData();
  final String tomtomApiKey = tomTomMapKey;
  PriceEstimationModel? priceEstimateModel;

  Future<Uint8List?> fetchAWS3Image(String posterImage) async {
    const region = awsRegion;
    const bucketId = awsBucketId;
    final AwsS3Client s3client = awsS3client;

    final listBucketResult = await s3client.listObjects();
    // prefix: "Wystle/Admin/rider-app/on-boarding/login-flash",
    // delimiter: "/");
    final response = await s3client.getObject(posterImage);

    setState(() {
      base64 = response.bodyBytes;
    });
    return base64;
  }

  Future<dynamic> getDataServices(
      double? sourceLatitude,
      double? sourceLongtitude,
      double? destinationLat,
      double? destinationLong) async {
    try {
      var response = await dio.get(
        'https://api.tomtom.com/routing/1/calculateRoute/$sourceLatitude,$sourceLongtitude:$destinationLat,$destinationLong/json?key=$tomtomApiKey',
      );

      if (response.statusCode == 200) {
        log("${response.data}");
        setState(() {
          routenav = RoutingMapModel.fromJson(response.data);
        });
      } else {
        log("Response data rather than 200");
      }
    } catch (e) {
      log("$e");
      // log("Api call exception");

    }
  }

  @override
  void initState() {
    super.initState();
    String? apiKey = googleSearchPlaceApi;
    googlePlace = GooglePlace(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstant.COLOR_BLACK,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_WHITE,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Find a Route',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: ColorConstant.COLOR_WHITE,
                fontWeight: FontWeight.w300,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin:
              const EdgeInsets.only(right: 20, left: 10, top: 0, bottom: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: widget.time != null ? true : false,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          border: Border.all(color: ColorConstant.COLOR_BLACK),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(widget.time.toString()),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Image.asset(
                          ImgConstants.ORIGIN_DESTINATION_ICON,
                          width: MediaQuery.of(context).size.width * 0.09,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          focusNode: sourceFocusNode,
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
                            labelStyle:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                            hintText: "Enter Source",
                            hintStyle:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
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
                          focusNode: destinationFocusNode,
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
                            labelStyle:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                            hintText: 'Enter Destination',
                            hintStyle:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
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
                            if (destinationfieldTextEditingController
                                    .isNotEmpty &&
                                destinationfieldTextEditingController.length >
                                    3) {
                              autoDestinationCompleteSearch(
                                  destinationfieldTextEditingController);
                            } else {
                              if (destinationpredictions.length > 3 &&
                                  mounted) {
                                setState(() {
                                  destinationpredictions = [];
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
                                sourceFocusNode.unfocus();
                                destinationFocusNode.unfocus();
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
                                debugPrint(predictions[index].placeId);

                                log('sourcelat ${address.first.coordinates.latitude}');
                                log('sourcelong ${address.first.coordinates.longitude}');

                                // List<geocodinglocation1.Location> locations =
                                //     await geocodinglocation1.locationFromAddress(
                                //         predictions[index].description.toString());

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
                              sourceFocusNode.unfocus();
                              destinationFocusNode.unfocus();
                              EasyLoading.show(status: 'loading...');

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

                              log('destinationlat ${address1.first.coordinates.latitude}');
                              log('destionationlong ${address1.first.coordinates.longitude}');

                              await getDataServices(
                                  sourceLat,
                                  sourceLong,
                                  address1.first.coordinates.latitude,
                                  address1.first.coordinates.longitude);

                              Map _body = {
                                "userid": userdata.userid,
                                "riderlocdetail": {
                                  "datetime": "28/08/2022 20:05:57",
                                  "picklat": sourceLat,
                                  "picklong": sourceLong,
                                  "droplat":
                                      address1.first.coordinates.latitude,
                                  "droplong":
                                      address1.first.coordinates.longitude,
                                },
                                "distancedetail": routenav?.routes?[0].summary
                              };

                              priceEstimateModel =
                                  await APIServices.getPriceListAPI(_body);
                              var imagePriceData = await fetchAWS3Image(
                                  priceEstimateModel?.estimationDetail?[index]
                                          .vehicleTopView ??
                                      '');

                              if (priceEstimateModel?.status == 'true') {
                                EasyLoading.dismiss();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TomTomMapRiding(
                                      sourceLat: sourceLat,
                                      sourceLong: sourceLong,
                                      destinationLat:
                                          address1.first.coordinates.latitude,
                                      destinationLong:
                                          address1.first.coordinates.longitude,
                                      priceEstimateModel: priceEstimateModel,
                                      image1: imagePriceData,
                                      routenav: routenav,
                                      destinationAddress:
                                          destinationfieldTextEditingController
                                              ?.text,
                                      sourceAddress:
                                          sourcefieldTextEditingController
                                              ?.text,
                                    ),
                                  ),
                                );
                              } else {
                                EasyLoading.dismiss();
                                showAlertDialog(
                                    context,
                                    priceEstimateModel?.message.toString() ??
                                        '');
                              }

                              if (mounted) {
                                setState(() {});
                              }
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

  // Alert Box

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: ColorConstant.COLOR_TEXT,
              fontWeight: FontWeight.w500,
            ),
      ),
      onPressed: () {
        if (mounted) {
          setState(() {
            sourcefieldTextEditingController?.clear();
            destinationfieldTextEditingController?.clear();
            predictions.clear();
            destinationpredictions.clear();
          });
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
