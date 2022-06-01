import 'dart:developer';

import 'package:wystle/model/concern_notification.dart';

import '../constant/dio_client.dart';
import '../model/boarding_model.dart';
import '../model/login_flash_model.dart';
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
      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_LOGIN_FLASH,
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
     
      var response = await dio.post(
          APIConstants.API_CALL_URL + APIConstants.API_CONCERN_NOTIFICATION,
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
      //  log("$e");
      log("Api call exception");
      return {
        "status": "false",
        "message": "Something went wrong",
        "data": null
      };
    }
  }
}
