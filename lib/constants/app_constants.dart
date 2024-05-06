
/// Purpose : library contains classes that has different category constants
library app_constants;

///this class holds shared preference key constants used throughout the app
class PrefKeys {
  static const String userEmail = "userEmail";
  static const String userId = "userId";
  static const String localeLanguageCode = "localeLanguageCode";
  static const String localeCountryCode = "localeCountryCode";
  static const String isNotificationEnabled = "isNotificationEnabled";
  static const String authProvider = "AuthProvider";
}

/// this class holds numeric constants used throughout app
class NumericConstants {
  static const int emailLength = 100;
  static const int deviceNameLength = 30;
  static const int maxAmountLimit = 10000000;
  static const int meterNumberLength = 13;
  static const int listMaxResultCount = 10;
  static const int gridMaxResultCount = 20;
  static const int homeDeviceListCount = 3;
  static const int homeProductListCount = 3;
}

/// this class holds data constants used throughout app
class DataConstants {
  static const String defaultLocaleLanguageCode = 'en';
  static const String defaultLocaleCountryCode = '';
  static const String googleDocEmbeddedUrl =
      'https://docs.google.com/gview?embedded=true&url=';
}
class Timeout {
  static const int connectTimeout = 600000;
  static const int receiveTimeout = 600000;
}

class Delay {
  Delay._();
  static const int screenTransitionDelayMillis = 1000;
  static const int downloadApiCallIntervalInMinutes = 30;
  static const int oneSecond = 1;
  static const int postDelayInMinutes = 15;
}

class APIHeaderConstants {
  APIHeaderConstants._();
  static const authorization = "Authorization";
  static const connectTimeout = "connectTimeout";
  static const receiveTimeout = "receiveTimeout";
  static const bearer = "Bearer ";
  static const cookie = "cookie";
  static const setCookie = "set-cookie";
}

class ResponseCode {
  ResponseCode._();
  static const int successOk = 200;
  static const int successCreated = 201;
  static const int successAccepted = 202;
  static const int successNoContent = 204;
  static const int errorMovedPermanently = 301;
  static const int errorFound = 302;
  static const int errorBadRequest = 400;
  static const int errorUnauthorized = 401;
  static const int errorForbidden = 403;
  static const int errorNotFound = 404;
  static const int errorMethodNotAllowed = 405;
  static const int errorNotAcceptable = 406;
  static const int errorInternalServerError = 500;
  static const int errorNotImplemented = 501;
}

class LoadingStatus {
  LoadingStatus._();
  static const String start = "loading";
  static const String campaignStart = "campaignLoading";
  static const String complete = "done";
}

class DateFormats {
  DateFormats._();
  static const String mmDdYyyy = "MM/dd/yyyy";
  static const String ddMYyyy = "dd-M-yyyy";
  static const String ddMYyyyHhMmSs = "dd-M-yyyy hh:mm:ss";
  static const String ddMmMmYyyy = "dd MMMM yyyy";
  static const String eDdMmmYyyyHhMmSs = "E, dd MMM yyyy HH:mm:ss";
  static const String eEeeHhMma = "EEEE hh:mm a";
  static const String mmmDdYyyyHhMmSsa = "MMM dd, yyyy, hh:mm:ss a";
  static const String dateFormatDdMmYyyy = "dd/MM/yyyy";
  static const String dateFormatLong = "dd MMMM, yyyy";
  static const String timeFormat = "h:mm aaa";
  static const String timeFormatWithSpacing = "h : mm aaa";
  static const String eEeeDdMmm = "EEEE dd MMMM";
  static const String hHMm = "HH:mm";
}

class APICallStatus {
  APICallStatus._();
  static const int inProgress = 2;
  static const int success = 1;
  static const int failure = 0;
}

String? deviceToken;
