import 'dart:developer';

import 'package:bloc_login_page/bloc/login/login_provider.dart';
import 'package:bloc_login_page/models/login/login_response.dart';
import 'package:flutter/material.dart';

class LoginRepository {
  final LoginProvider _loginProvider = LoginProvider();

  //  final String username;

  //  final String password;

  LoginRepository();

  // Get User Login Reponse
  Future<LoginResponse> getLoginResponse(
      {required String username, required String password}) async {
    log("Repo calling");
    LoginResponse response = await _loginProvider.getLoginResponse(
        username: username, password: password);
    log("End Repo calling");
    return response;
  }
}
