import 'dart:convert';

import 'package:wystle/module/sharedpreference/shared_preference.dart';

import '../../model/email_otp_register_model.dart';
import '../../service/api_constants.dart';

class UserData {
  static UserDetail geUserData() {
    var user = jsonDecode(SharedPreference.getValue(PrefConstants.USER_DATA));

   return UserDetail.fromJson(user);
  }
}
