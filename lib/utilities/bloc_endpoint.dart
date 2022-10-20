class BlocEndpoint {
  BlocEndpoint();

  /// User Endpoints
  /// --------------
  /// Get User Authentication URL
  static String getAuthenticationURL() {
    return APIConfiguration.baseUrl +
        "/api/" +
        APIConfiguration.version +
        "/" +
        "auth/login";
  }
}

class APIConfiguration {
  static const baseUrl = "https://atxtest.atx.my";
  static const version = "v1";
}
