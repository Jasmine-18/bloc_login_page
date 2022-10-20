class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({required this.username, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    
    String username = json['username'];
    String password = json['password'];

    return LoginRequestModel(username: username,password: password);
  }
}
