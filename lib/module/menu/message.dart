import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstant.COLOR_BLACK,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: ColorConstant.COLOR_WHITE,
            size: 25,
          ),
        ),
        title: Text('Messages',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.COLOR_BLACK),
                            height: 45,
                            width: 45,
                            child: const Icon(Icons.redeem,
                                color: ColorConstant.COLOR_WHITE),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            "50% off on First Ride",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_TEXT,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            "Get 50% cb up to Rs 75 on your first order. Use code: First50",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_ORIGINAL_GREY,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          ////ElevatedButton(onPressed: (), child: child)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.COLOR_BLACK),
                      height: 45,
                      width: 45,
                      child: const Icon(Icons.currency_rupee,
                          color: ColorConstant.COLOR_WHITE),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "50% off with Amazon Pay",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_TEXT,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Get 50% cb up to Rs 75 on your first order. Use code: Amz50",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_ORIGINAL_GREY,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// import '../../constant/color_constant.dart';

// class Inbox extends StatelessWidget {
//   const Inbox({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorConstant.COLOR_BLACK,
//         centerTitle: false,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.close,
//             color: ColorConstant.COLOR_WHITE,
//             size: 25,
//           ),
//         ),
//         title: Text(
//           'Inbox',
//           style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                 color: ColorConstant.COLOR_WHITE,
//                 fontWeight: FontWeight.w600,
//               ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 15.0),
//             child: Row(
//               children: [
//                 Text(
//                   'Help',
//                   style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                         color: ColorConstant.COLOR_WHITE,
//                         fontWeight: FontWeight.w600,
//                       ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 const Icon(Icons.help),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 30.0, right: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.message),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15.0, bottom: 15),
//                 child: Text(
//                   'You have no messages',
//                   style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                         color: ColorConstant.COLOR_BLACK,
//                         fontWeight: FontWeight.w500,
//                       ),
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   'When you receive message, you will be able to see them here.',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                         color: ColorConstant.COLOR_BLACK,
//                         fontWeight: FontWeight.w500,
//                       ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
