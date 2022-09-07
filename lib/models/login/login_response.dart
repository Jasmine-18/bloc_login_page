class LoginResponse {
  String message;
  String accessToken;

  LoginResponse({required this.message, required this.accessToken});

  fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['access_token'] = accessToken;
    return data;
  }
}
