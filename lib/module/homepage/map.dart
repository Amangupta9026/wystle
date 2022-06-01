import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/module/homepage/search_destination.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../testing/mapapi_testing.dart';

class Map1 extends StatefulWidget {
  const Map1({Key? key}) : super(key: key);

  @override
  State<Map1> createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchDestination()),
          );
          log("click destination");
        },
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.COLOR_BLACK)),
          child: const Text(
            'Search Destination',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorConstant.COLOR_BLACK,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: TomTomMapApiTesting()),
          Padding(
            padding: const EdgeInsets.only(
                top: 40.0, left: 20, right: 20, bottom: 0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstant.COLOR_WHITE,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorConstant.COLOR_BLACK,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
