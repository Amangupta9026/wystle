import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/widget/appbar_widget.dart';

class MyLocations extends StatelessWidget {
  const MyLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30.0, 30, 30, 0),
              child: AppBarWidget(
                text1: 'Saved Places',
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [
                  Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstant.COLOR_BLACK),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Location',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        'Current Location',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      PopupMenuButton(
                          color: Colors.white,
                          elevation: 20,
                          enabled: true,
                          onSelected: (value) {
                            log('value: $value');
                          },
                          onCanceled: () {
                            //do something
                          },
                          itemBuilder: (context) => [
                                const PopupMenuItem(
                                  child: Text("Edit"),
                                  value: "edit",
                                ),
                                const PopupMenuItem(
                                  child: Text("Delete"),
                                  value: "delete",
                                ),
                              ]),
                    ],
                  )
                ]),
              ),
            ),
          ],
        ),
      )),
    );
  }

  showOnClick(BuildContext context) {
    return Container(
        height: 200,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              'Edit',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorConstant.COLOR_TEXT,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Delete',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorConstant.COLOR_TEXT,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ));
  }

  void actionPopUpItemSelected(String value) {
    // _scaffoldkey.currentState.hideCurrentSnackBar();
    String message;
    if (value == 'edit') {
      message = 'You selected edit for';
    } else if (value == 'delete') {
      message = 'You selected delete fo';
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    // _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}
