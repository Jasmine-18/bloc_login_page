// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc_login_page/models/login/login_request.dart';
import 'package:bloc_login_page/models/login/login_response.dart';
import 'package:bloc_login_page/utilities/bloc_endpoint.dart';
import 'package:bloc_login_page/utilities/dio_client.dart';
import 'package:dio/dio.dart';

abstract class LoginProviderInterface {
  /// Get All Product Categories
  Future<LoginResponse> getLoginResponse(
      {required String username, required String password});
}

class LoginProvider implements LoginProviderInterface {
  String endpoint = BlocEndpoint.getAuthenticationURL();

  LoginProvider();

  @override
  Future<LoginResponse> getLoginResponse(
      {required String username, required String password}) async {
    log("Provider calling");
    DioClient _dioClient = DioClient(endpoint);

    // LoginRequestModel request = LoginRequestModel.fromJson({
    //   "login": username,
    //   "password": password,
    // });

    Response dioResponse = await _dioClient.dioPost(request: {
      "login": username,
      "password": password,
    });
    log("End Provider calling");
    log("${dioResponse.data}");
    if (dioResponse.data['token'] != null) {
      LoginResponse response = LoginResponse(
          message: 'Success',
          accessToken: dioResponse.data['token']['access_token']);
      return response;
    }

    throw UnimplementedError();
  }
}
