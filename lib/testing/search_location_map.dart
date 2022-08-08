// // ignore_for_file: unused_field

// import "package:flutter/material.dart";
// import "package:flutter_map/flutter_map.dart";
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
// import 'package:wystle/constant/color_constant.dart';
// import 'package:wystle/constant/image_constant.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// // ignore: must_be_immutable
// class SearchLocationMap extends StatefulWidget {
//   final int? lat;
//   final double? latitude;
//   final double? longitude;

//   const SearchLocationMap({Key? key, this.lat, this.latitude, this.longitude})
//       : super(key: key);

//   @override
//   State<SearchLocationMap> createState() => _SearchLocationMapState();
// }

// class _SearchLocationMapState extends State<SearchLocationMap> {
//   LocationData? _currentPosition;

//   final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";

//   //"PQ5tTEag90xOPau3hA1KGp8NN6ArkBDA";
//   // LatLng startLocation = LatLng(26.748933, 83.3588367);

//   LatLng endLocation = LatLng(26.999933, 84.2077329);

//   int selectedTile = 0;

//   @override
//   Widget build(BuildContext context) {
//     // LatLng startLocation = LatLng(widget.latitude, widget.longitude);
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 2,
//             child: FlutterMap(
//               options: MapOptions(

//                   // onMapCreated: _handle(),
//                   // onTap: _nav(),
//                   debugMultiFingerGestureWinner: true,
//                   enableMultiFingerGestureRace: true,
//                   allowPanningOnScrollingParent: false,
//                   allowPanning: false,
//                   enableScrollWheel: false,
//                   center: LatLng(widget.latitude!.toDouble(),
//                       widget.longitude!.toDouble()),
//                   //startLocation,
//                   zoom: 16.0),

//               // options: MapOptions(
//               //   center: LatLng(0, 0),
//               //   zoom: 18.0,
//               // ),
//               children: [
//                 TileLayerWidget(
//                   options: TileLayerOptions(
//                       tileProvider: const CachedTileProvider(),
//                       urlTemplate:
//                           "https://api.tomtom.com/map/1/tile/basic/main/"
//                           "{z}/{x}/{y}.png?key={apiKey}",
//                       additionalOptions: {"apiKey": apiKey}),
//                   // urlTemplate:
//                   //     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   //  subdomains: ['a', 'b', 'c']),
//                   //  tileProvider: const CachedTileProvider()),
//                 ),
//                 MarkerLayerWidget(
//                   options: MarkerLayerOptions(
//                     rotate: false,
//                     markers: [
//                       Marker(
//                         width: 40.0,
//                         height: 40.0,
//                         point: LatLng(widget.latitude!.toDouble(),
//                             widget.longitude!.toDouble()),
//                         //LatLng(26.748989, 83.358857),
//                         builder: (ctx) => const Icon(Icons.location_on,
//                             size: 35.0, color: Colors.blue),
//                       ),
//                       // Marker(
//                       //   width: 80.0,
//                       //   height: 80.0,
//                       //   point: endLocation,
//                       //   builder: (ctx) => Container(
//                       //     child: Icon(Icons.location_on),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 // PolylineLayerWidget(
//                 //   options: PolylineLayerOptions(
//                 //     //  polylineCulling: true,
//                 //     polylines: List.generate(
//                 //       10,
//                 //       (index) => Polyline(
//                 //         //   isDotted: true,
//                 //         points: [
//                 //           startLocation,
//                 //           endLocation
//                 //           // LatLng(26.7489332, 83.3588367),
//                 //           // LatLng(26.999933, 84.2077329)
//                 //         ],
//                 //         strokeWidth: 10.0,
//                 //         color: Colors.blue,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           bottomDetailsSheet(),
//         ],
//       ),
//     );
//   }

//   Widget bottomDetailsSheet() {
//     return DraggableScrollableSheet(
//       initialChildSize: .5,
//       minChildSize: .5,
//       maxChildSize: 1,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return Container(
//           color: ColorConstant.COLOR_WHITE,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: Center(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     height: 2,
//                     color: ColorConstant.COLOR_ORIGINAL_GREY,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                     itemCount: 10,
//                     controller: scrollController,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(
//                             left: 15.0, right: 15, bottom: 25),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Column(
//                                   children: [
//                                     Image.asset(ImgConstants.CAR_ICON,
//                                         width: 50, height: 50),
//                                   ],
//                                 ),
//                                 const SizedBox(width: 20),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "My Audi",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .subtitle1
//                                           ?.copyWith(
//                                             color: ColorConstant.COLOR_TEXT,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "5:08 pm",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .subtitle2
//                                           ?.copyWith(
//                                             color: ColorConstant
//                                                 .COLOR_ORIGINAL_GREY,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Spacer(),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.discount,
//                                           size: 15,
//                                         ),
//                                         const SizedBox(width: 5),
//                                         Text(
//                                           "Rs. 89.50",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .subtitle1
//                                               ?.copyWith(
//                                                 color: ColorConstant.COLOR_TEXT,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "Rs. 99.50",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .caption
//                                           ?.copyWith(
//                                             color: ColorConstant
//                                                 .COLOR_ORIGINAL_GREY,
//                                             fontWeight: FontWeight.w600,
//                                             decoration:
//                                                 TextDecoration.lineThrough,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // class CachedTileProvider extends TileProvider {
// //   // const CachedTileProvider();
// //   @override
// //   ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
// //     return CachedNetworkImageProvider(
// //       getTileUrl(coords, options),
// //       //Now you can set options that determine how the image gets cached via whichever plugin you use.
// //     );
// //   }
// // }
