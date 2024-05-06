library apiconstants;

///base url for different environments
class APIEnvironment {
  static const String prod = "https://production.com";
  static const String dev = "https://test.com";
}

Map<String, String> getTermsOfServiceUrl = {
  APIEnvironment.dev:
      "https://production.com/terms-services",
  APIEnvironment.prod: "https://test.com/terms-services",
};

Map<String, String> getPrivacyPolicyUrl = {
  APIEnvironment.dev:
      "https://test.com/privacy-policy",
  APIEnvironment.prod: "https://production.com/privacy-policy",
};

class APIMethods {
  static const String get = "get";
  static const String put = "put";
  static const String post = "post";
  static const String delete = "delete";
}

class APIPath {
  //auth
  static const String login = "/login";
  static const String signUp = "/api/Create";
  static const String forgotPassword = "/api/ForgetPassword";
}

