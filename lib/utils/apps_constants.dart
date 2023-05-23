class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;
//http://mvs.bslmeiyu.com  http://10.0.2.2:8000
  static const String BASE_URL = "http://192.168.1.6:8000";
  static const String POPULAR_PRODACT_URL = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODACT_URL = "/api/v1/products/recommended";
  //static const String DRINK_URL = "/api/v1/products/drinks";
  static const String UPLOAD_URL = "/uploads/";

  //user and auth and points
  static const String REGISTRATION_URL = "/api/v1/auth/register";
  static const String LOGIN_URL = "/api/v1/auth/login";
  static const String USERINFO_URL = "/api/v1/customer/info";
  static const String TOKEN = "token";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "cart_list";
  static const String CART_HISTORY_LIST = "cart_history_list";
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
}
