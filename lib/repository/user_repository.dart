import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  const UserRepository();

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    var data = {
      "login": username,
      "password": password,
    };
    var body = json.encode(data);
    var header = {
      'content-Type': 'application/json',
    };
    var link = Uri.parse("https://atxtest.atx.my/api/v1/auth/login");
    var response = await http.post(link, body: body, headers: header);
    return json.decode(response.body);
  }
}
