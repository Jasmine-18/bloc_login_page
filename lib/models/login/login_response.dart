class LoginResponse {
  String message;
  String accessToken;

  LoginResponse({required this.message, required this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    String message = json['message'];
    String accessToken = json['access_token'];
    return LoginResponse(message: message, accessToken: accessToken);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['access_token'] = accessToken;
    return data;
  }
}
