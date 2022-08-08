// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../constant/color_constant.dart';

// void getScheduleRideBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: false,
//         backgroundColor: Colors.transparent,
//         builder: (ctx) {
//           return Container(
//               height: MediaQuery.of(context).size.height * 0.4,
//               color: ColorConstant.COLOR_WHITE,
//               child: Column(mainAxisSize: MainAxisSize.min, children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20.0, bottom: 12),
//                   child: Text(
//                     'Schedule a Ride',
//                     style: Theme.of(context).textTheme.headline5?.copyWith(
//                           color: ColorConstant.COLOR_TEXT,
//                           fontWeight: FontWeight.w500,
//                         ),
//                   ),
//                 ),
//                 const Divider(
//                   color: ColorConstant.COLOR_ORIGINAL_GREY,
//                   thickness: 0.3,
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101));

//                     if (pickedDate != null) {
//                       String formattedDate =
//                           DateFormat('yyyy-MM-dd').format(pickedDate);

//                       setState(() {
//                         dateinput.text = formattedDate;
//                       });
//                       setState(() {});
//                     } else {
//                       log("Date is not selected");
//                     }
//                   },
//                   child: Column(
//                     children: [
//                       dateinput.text != null
//                           ? Text(dateinput.text)
//                           : Text(
//                               'Select Date',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText2
//                                   ?.copyWith(
//                                     color: ColorConstant.COLOR_TEXT,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                             ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Divider(
//                   color: ColorConstant.COLOR_ORIGINAL_GREY,
//                   thickness: 0.3,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 InkWell(
//                     onTap: () {
//                       _selectTime(context);
//                     },
//                     child: Text(
//                         "${selectedTime.hour}:${selectedTime.minute} - ${selectedTime.hour}:${selectedTime.minute + 10}")),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Divider(
//                   color: ColorConstant.COLOR_ORIGINAL_GREY,
//                   thickness: 0.3,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => GoogleSearchPlace(
//                                 yourLocation: getAddress,
//                                 time: selectedTime.toString(),
//                               )),
//                     );
//                   },
//                   child: MaterialButton1(
//                     width1: MediaQuery.of(context).size.width * 0.75,
//                     txt1: 'Set pickup time',
//                     height1: 50,
//                   ),
//                 )
//               ]));
//         });
//   }

//   _selectTime(BuildContext context) async {
//     final TimeOfDay? timeOfDay = await showTimePicker(
//       confirmText: "CONFIRM",
//       cancelText: "NOT NOW",
//       context: context,
//       initialTime: TimeOfDay.now(),
//       initialEntryMode: TimePickerEntryMode.dial,
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       // if(selectedTime.minute >= 60) {
//       //     selectedTime = TimeOfDay(
//       //         hour: timeOfDay.hour,
//       //         minute: timeOfDay.minute + 10);
//       //       setState(() {
//       //         add10MinuteTime = timeOfDay.hour.toString() + ":" + (timeOfDay.minute + 10).toString();
//       //       });
//       // }
//       setState(() {
//         selectedTime = timeOfDay;
//         add10MinuteTime = DateTime.now();
//         DateTime(selectedTime.hour, selectedTime.minute);

//         add10MinuteTime.add(const Duration(hours: 1));
//       });
//     }

//     setState(() {});
//   }
