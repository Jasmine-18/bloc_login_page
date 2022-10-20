import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  //Constructor
  static AppPreferences _instance = AppPreferences._internal();

  AppPreferences._internal();

  factory AppPreferences() => _instance;

  String _accessToken = '';
  String _loginProvider = '';
  Map<String, dynamic> _facebookProfile = {};

  String get accessToken => _accessToken;
  String get loginProvider => _loginProvider;
  Map<String, dynamic> get facebookProfile => _facebookProfile;

  init() async {
    _accessToken = await AppPreferences.getAccessToken();
    _facebookProfile = await AppPreferences.getFacebookProfile();
    _loginProvider = await AppPreferences.getLoginProvider();
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
    await AppPreferences().init();
  }

  static Future<String> getLoginProvider() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = await localStorage.getString("login_provider") ?? '';
    return token;
  }

  static Future<void> setLoginProvider(String loginProvider) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString("login_provider", loginProvider);
    await AppPreferences().init();
  }

  static Future<Map<String, dynamic>> getFacebookProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Map<String, dynamic> facebookProfile = {};
    final encodedFacebookProfile =
        await localStorage.getString("encoded_facebook_profile") ?? '';
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
        "encoded_facebook_profile", encodedFacebookProfile);
    await AppPreferences().init();
  }

  static Future<void> logoutClearPreferences() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove("access_token_key");
    await localStorage.remove("encoded_facebook_profile");
    await localStorage.remove("login_provider");
    await AppPreferences().init();
  }
}
