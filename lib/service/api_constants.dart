// ignore_for_file: constant_identifier_names

class APIConstants {
  static const String BASE_URL = "http://wystlelogicbox.k2ai.com/";
  static const String Amazon_S3_URL = "https://s3.eu-west-2.amazonaws.com";

  static const String API_BASE_URL = BASE_URL + "be_api/";

  static const String API_VERSION = "app_auth/rider/";
  static const String API_CALL_URL = API_BASE_URL + API_VERSION;
  static const CONNECTION_TIMEOUT = 300000;
  static const RECEIVE_TIMEOUT = 300000;

  /// API Requests
  static const String API_BOARDING = "get_rider_ob_poster_detail";
  static const String API_LOGIN_FLASH = "get_rider_ob_login_flash_detail";
  static const String API_CONCERN_NOTIFICATION =
      "get_rider_ob_concern_notification_detail";
}

class PrefConstants {
  /// header data
  static const String ACCESS_TOKEN = "access-token";
  static const String FIREBASE_TOKEN = "firebaseToken";

  static const String IS_LOGIN = "isLogin";
  static const String USER_ID = "userId";
  static const String LATITUDE = "latitude";
  static const String LONGITUDE = "longitude";
}
