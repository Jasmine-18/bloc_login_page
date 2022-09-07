import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  //Constructor
  static AppPreference _instance = AppPreference._internal();

  AppPreference._internal();

  factory AppPreference() => _instance;

  String _accessToken = '';
  Map<String, dynamic> _facebookProfile = {};

  String get accessToken => _accessToken;
  Map<String, dynamic> get facebookProfile => _facebookProfile;

  init() async {
    _accessToken = await AppPreference.getAccessToken();
    _facebookProfile = await AppPreference.getFacebookProfile();
  }

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<String> getAccessToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = await localStorage.getString("access_token_key") ?? '';
    return token;
  }

  static Future<void> setAccessToken(String accessToken) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString("access_token_key", accessToken);
    await AppPreference().init();
  }

  static Future<Map<String, dynamic>> getFacebookProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Map<String, dynamic> facebookProfile = {};
    final encodedFacebookProfile =
        await localStorage.getString("encodedFacebookProfile") ?? '';
    if (encodedFacebookProfile.isNotEmpty) {
      facebookProfile = json.decode(encodedFacebookProfile);
    }
    // Map<String, dynamic> facebookProfile = json.decode(encodedFacebookProfile);
    return facebookProfile;
  }

  static Future<void> setFacebookProfile(
      Map<String, dynamic> facebookProfile) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String encodedFacebookProfile = json.encode(facebookProfile);
    await localStorage.setString(
        "encodedFacebookProfile", encodedFacebookProfile);
    await AppPreference().init();
  }

  static Future<void> logoutClearPreferences() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove("access_token_key");
    await localStorage.remove("encodedFacebookProfile");

    await AppPreference().init();
  }
}
