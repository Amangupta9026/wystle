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
  static const String API_OTPVERIFY = "send_sms_to_rider_mobile_number";
  static const String API_LOGIN = "login_rider";
  static const String API_REGISTER_VERIFY =
      "send_verification_code_to_rider_email";
  static const String API_EMAIL_REGISTER_VERIFY = "register_rider";
  static const String API_LOGOUT = "rider_logout";
  static const String API_VERIFY_RIDER_EMAIL = "verify_rider_email";
  static const String API_VERIFY_EMAIL_SUCCESS =
      "rider_email_verification_success";
  static const String API_LOGIN_AFTER_CALL = "login_rider_cookies";
  static const String API_USER_LOCATION = "predict_rider_location_from_geopoint";
}

class PrefConstants {
  /// header data
  static const String ACCESS_TOKEN = "access-token";
  static const String FIREBASE_TOKEN = "firebaseToken";

  static const String IS_LOGIN = "isLogin";
  static const String USER_ID = "userId";
  static const String LATITUDE = "latitude";
  static const String LONGITUDE = "longitude";
  static const String DEVICE_NAME = "deviceName";
  static const String DEVICE_BRAND = "deviceBrand";
  static const String DEVICE_ID = "deviceId";
  static const String DEVICE_VERSION = "deviceVersion";
  static const String DEVICE_MANUFACTURING = "deviceManufacturing";
  static const String MOBILE_NUMBER = "mobileNumber";
  // static const String AUTH_TOKEN = "authToken";
  static const String USER_DATA = "userData";
  static const String USER_EMAIL_VERIFY_TAG = "userEmailVerifyTag";

  static const String USER_CURRENT_STREET = "userStreetLocation";
   static const String USER_CURRENT_SUBLOCALITY = "userSubLocalLocation";
  static const String USER_CITY = "userCity";
  static const String USER_COUNTRY = "userCountry";
  static const String USER_STATE = "userState";
  static const String LOCALITY = "userSubLocalLocation";
  static const String IP_ADDRESS = "ipAddress";
  static const String USER_LOCATION_DATA = "userLocationData";
}
