import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wystle/model/concern_notification.dart';
import 'package:wystle/model/logout_model.dart';
import 'package:wystle/module/sharedpreference/userdata.dart';

import '../constant/dio_client.dart';
import '../model/boarding_model.dart';
import '../model/email_otp_register_model.dart';
import '../model/email_verify_success_model.dart';
import '../model/login_cookies_model.dart';
import '../model/login_flash_model.dart';
import '../model/login_model.dart';
import '../model/otpverify_model.dart';
import '../model/user_location_model.dart';
import '../model/verify_registry_model.dart';
import '../module/sharedpreference/shared_preference.dart';
import 'api_constants.dart';

class APIServices {
  static Future<dynamic> getBoardingAPI(Map apiParam) async {
    try {
      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_BOARDING,
          data: apiParam);
      if (response.statusCode == 200) {
        log("${response.data}");
        return BoardingModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // Login Flash API

  static Future<dynamic> getLoginFlashAPI(Map loginApiParam) async {
    try {
      var userdata = UserData.geUserData();

      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_LOGIN_FLASH,
          options: Options(
            headers: {
              "authtoken": userdata.authToken,
            },
          ),
          data: loginApiParam);
      if (response.statusCode == 200) {
        log("${response.data}");
        return LoginFlashModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // Concern Notification API

  static Future<dynamic> getConcernNotificationAPI(Map concernApiParam) async {
    try {
      var userdata = UserData.geUserData();

      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_CONCERN_NOTIFICATION,
          options: Options(
            headers: {
              "authtoken": userdata.authToken,
            },
          ),
          data: concernApiParam);
      if (response.statusCode == 200) {
        log("${response.data}");
        return ConcernNotificationModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      // log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // OTP Verification API

  static Future<dynamic> getOTPVerifyAPI(
    String mobileNumber,
  ) async {
    try {
      var response = await dio
          .post(APIConstants.API_CALL_URL + APIConstants.API_OTPVERIFY, data: {
        "mobileno": mobileNumber,
      });
      // log(mobileNumber.toString());
      if (response.statusCode == 200) {
        log("${response.data}");
        return OTPVerifyModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // LOgin API

  static Future<dynamic> getLoginAPI(Map loginData) async {
    try {
      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_LOGIN,
          data: loginData);
      log('data ${loginData.toString()}');
      if (response.statusCode == 200) {
        log("${response.data}");
        var loginData = LoginModel.fromJson(response.data);
        if (loginData.status == "true") {
          SharedPreference.setValue(
              PrefConstants.USER_DATA, jsonEncode(loginData.userDetail));
          SharedPreference.setValue(PrefConstants.USER_EMAIL_VERIFY_TAG,
              loginData.userDetail?.emailverifytag);
          
        }

        return loginData;
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // Register API First Name. Last Name & Email

  static Future<dynamic> getVerifyRegisterAPI(
      String email, String firstName, String lastName) async {
    Map _body = {"email": email, "firstname": firstName, "lastname": lastName};

    try {
      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_REGISTER_VERIFY,
          data: _body);
      // log(_body.toString());
      if (response.statusCode == 200) {
        log("${response.data}");
        return VerifyRegisterModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // After Register Call OTP Screen - EmailOTP Register API

  static Future<dynamic> getVerifyEmailOTPRegisterAPI(
      String email,
      String firstName,
      String lastName,
      String mobileNumber,
      String deviceId,
      String emailVerifying) async {
    Map _body = {
      "email": email,
      "firstname": firstName,
      "lastname": lastName,
      "mobileno": mobileNumber,
      "deviceid": deviceId,
      "emailverifytag": emailVerifying,
    };

    try {
      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_EMAIL_REGISTER_VERIFY,
          data: _body);
      log(_body.toString());
      if (response.statusCode == 200) {
        // if(response.data)

        var emailData = EmailOTPRegisterModel.fromJson(response.data);
        if (emailData.status == "true") {
          SharedPreference.setValue(
              PrefConstants.USER_DATA, jsonEncode(emailData.userDetail));
          SharedPreference.setValue(PrefConstants.USER_EMAIL_VERIFY_TAG,
              emailData.userDetail?.emailverifytag);
        }

        return emailData;
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // Logout

  static Future<dynamic> getLogoutAPI(int userId) async {
    try {
      var userdata = UserData.geUserData();

      var response =
          await dio.post(APIConstants.API_CALL_URL + APIConstants.API_LOGOUT,
              options: Options(
                headers: {
                  "authtoken": userdata.authToken,
                },
              ),
              data: {"userid": userId});
      if (response.statusCode == 200) {
        log("${response.data}");
        return LogoutModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // Verify Rider Email

  static Future<dynamic> getVerifyEmailRiderAPI(int userId) async {
    try {
      var userdata = UserData.geUserData();

      var response = await dio
          .post(APIConstants.API_CALL_URL + APIConstants.API_VERIFY_RIDER_EMAIL,
              options: Options(
                headers: {
                  "authtoken": userdata.authToken,
                },
              ),
              data: {"userid": userId});
      if (response.statusCode == 200) {
        log("${response.data}");
        return VerifyRegisterModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // Veriified Rider Email OTP Success

  static Future<dynamic> getVerifiedEmailSuccessAPI(int userId) async {
    try {
      var userdata = UserData.geUserData();

      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_VERIFY_EMAIL_SUCCESS,
          options: Options(
            headers: {
              "authtoken": userdata.authToken,
            },
          ),
          data: {"userid": userId});
      if (response.statusCode == 200) {
        log("${response.data}");
        return EmailVerifiedSuccessModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // After LOgin API Call

  static Future<dynamic> getAfterLoginAPI(
    String location,
    String country,
    String state,
    String city,
    String ipadd,
    String device,
    String deviceId,
    String devicebrand,
    String deviceMfg,
    String deviceName,
    String deviceOs,
    String dateTime,
  ) async {
    try {
      var userdata = UserData.geUserData();

      Map _body = {
        "userid": userdata.userid,
        "location": location,
        "country": country,
        "state": state,
        "city": city,
        "ipadd": ipadd,
        "device": device,
        "deviceid": deviceId,
        "devicebrand": devicebrand,
        "devicemfg": deviceMfg,
        "devicename": deviceName,
        "deviceos": deviceOs,
        "time": dateTime
      };
      log('before ${_body.toString()}');
      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_LOGIN_AFTER_CALL,
          options: Options(
            headers: {
              "authtoken": userdata.authToken,
            },
          ),
          data: _body);
      // log(_body.toString());
      if (response.statusCode == 200) {
        log("${response.data}");
        return LoginCookiesModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // Get City Name, State Name, Country Name

  static Future<dynamic> getUserLocationAPI() async {
    try {
      var userdata = UserData.geUserData();

      Map _body = {
        "userid": userdata.userid,
        "predparam": {
          "geo_lat": SharedPreference.getValue(
              PrefConstants.LATITUDE), // "51.44244732098324",
          "geo_long": SharedPreference.getValue(
              PrefConstants.LONGITUDE) //   "-0.4145904688180463"
        }
      };
      // log('before ${_body.toString()}');
      var response = await dio.post(
          'http://wystlegeo.k2ai.com/be_api/admin/aimodules/predict_rider_location_from_geopoint',
          // APIConstants.API_CALL_URL + APIConstants.API_USER_LOCATION,
          options: Options(
            headers: {
              "authtoken": userdata.authToken,
            },
          ),
          data: _body);
      // log(_body.toString());
      if (response.statusCode == 200) {
        log("${response.data}");
        return UserLocationModel.fromJson(response.data);
      } else {
        log("Response data rather than 200");
        return {
          "status": "false",
          "message": "Something went wrong",
          "data": null
        };
      }
    } catch (e) {
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }

  // static Future<dynamic> getDataServices() async {
  //   try {
  //     var response = await dio.post(
  //       'http://65.1.91.159:8002/route?json={"locations":[{"lat":51.513159,"lon":-0.089380},{"lat":51.518407,"lon":-0.126330}],"costing":"auto","directions_options":{"units":"miles"}}',
  //     );

  //     if (response.statusCode == 200) {
  //       log("${response.data}");
  //       return RouteNavigationModel.fromJson(response.data);
  //     } else {
  //       log("Response data rather than 200");
  //     }
  //   } catch (e) {
  //     //  log("$e");
  //     log("Api call exception");
  //   }
  // }
}
