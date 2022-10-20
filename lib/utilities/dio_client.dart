import 'dart:convert';
import 'dart:developer';

import 'package:bloc_login_page/utilities/constants.dart';
import 'package:bloc_login_page/utilities/dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final String endpoint;
  DioClient(this.endpoint)
      : _dio = Dio(
          BaseOptions(
            // baseUrl: 'https://atxtest.atx.my/',
            connectTimeout: 5000,
            receiveTimeout: 3000,
            responseType: ResponseType.json,
            headers: {
              "Content-Type": "application/json",
              // "X-Requested-With": "XMLHttpRequest",
            },
          ),
        );

  final Dio _dio;

  // HTTP request methods will go here
  Future<Response<dynamic>> dioPost({required Object request}) async {
    try {
      log("Dio calling");
      log("$endpoint");
      log("${json.encode(request)}");
      log("${_dio.options.headers}");

      final response = await _dio.post(
        endpoint,
        data: json.encode(request),
      );
      log("ENd Dio calling");
      return response;
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }
}
