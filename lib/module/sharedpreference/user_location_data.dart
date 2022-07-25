import 'dart:convert';

import 'package:wystle/module/sharedpreference/shared_preference.dart';
import '../../model/user_location_model.dart';
import '../../service/api_constants.dart';

class UserLocationData {
  static PredResult getUserLocationData() {
    // var userLocation =
    //     jsonDecode(SharedPreference.getValue(PrefConstants.USER_LOCATION_DATA));

    var userLocation =
        SharedPreference.getValue(PrefConstants.USER_LOCATION_DATA) != null
            ? jsonDecode(
                SharedPreference.getValue(PrefConstants.USER_LOCATION_DATA))
            : null;

    return PredResult.fromJson(userLocation);
  }
}
