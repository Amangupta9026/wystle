import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectLineByLine extends StatelessWidget {
  // final int? count;
  final double? width1;
  final double? height1;
  const ShimmerEffectLineByLine(
      {Key? key,
      // this.count,
      this.width1,
      this.height1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height1,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child:
            // ListView.builder(
            //     itemCount: count ?? 1,
            //     itemBuilder: (BuildContext context, int index) {
            // return
            Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: width1,
            height: height1,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            // );
            // }
          ),
        ),
      ),
    );
  }
}
