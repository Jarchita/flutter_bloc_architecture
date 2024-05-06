import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config.dart';
import '../../exports/constants.dart';
import '../../exports/utilities.dart';
import '../../repository/api_client.dart';

/// Purpose : Api service class that will set the client

class ApiService  {
  ApiService() {
    getHeadersAndAddLogInterceptor();
    setApiClient();
  }

  final Dio _dio = Dio();
  final Dio _authDio = Dio();
  ApiClient? client;
  ApiClient? authClient;
  String? _accessToken;

  ///  This method is used to get API client. Here, i have set
  /// the interceptor to perform session expiry task and also added code for
  /// cookie delete.
  Future<Dio> getApiClient(Dio dio, {String? baseUrl}) async {
    print(baseUrl);
    dio.options.baseUrl = baseUrl ?? AppConfig.apiEnvironment;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (option, handler) async {
          handler.next(option);
        },
        onResponse: (response, handler) async {
          handler.next(response);
        },
        onError: (err, handler) async {
          /// logging exception and sending it to respected view.
          handler.reject(err);
        },
      ),
    );

    return dio;
  }

  bool _isJson(String data) {
    try {
      json.decode(data);
    } catch (e) {
      return false;
    }
    return true;
  }

  /// method to get error message from response
  String? getError(dynamic e) {
    try {
      if (e.type == DioExceptionType.badResponse) {
        final data = e.response.data;

        //if error is in json format
        if (data is String) {
          if (_isJson(data)) {
            final decodedData = json.decode(data);
            if (decodedData["error"]["validationErrors"] != null) {
              return decodedData["error"]["validationErrors"][0]["message"]
                  .toString();
            } else {
              return decodedData["error"]["message"]?.toString();
            }
          }
        } else {
          //comes in auth api
          if (data["error"] == "invalid_grant") {
            return "Email ID and Password did not match";
          } else if (data["error_description"] != null) {
            return data["error_description"]!.toString();
          }

          //comes in other apis
          else if (data["error"]["validationErrors"] != null) {
            return data["error"]["validationErrors"][0]["message"].toString();
          } else {
            return data["error"]["message"]?.toString();
          }
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  ///check for socket exception
  bool isSocketException(dynamic e) =>
      e.message.toString().contains('SocketException');

  /// get access token from storage and append in header also adding
  /// all other required headers.
  Future getHeadersAndAddLogInterceptor() async {
    final prefs = await SharedPreferences.getInstance();
    // _accessToken = prefs.getString(PrefKeys.accessToken);

    print("accessToken  $_accessToken");
    if (_accessToken != null) {
      _dio.options.headers[APIHeaderConstants.authorization] =
          '${APIHeaderConstants.bearer} $_accessToken';
    }
    _dio.options.contentType = "application/json";
    _authDio.options.contentType = "application/x-www-form-urlencoded";
    // _dio.options.connectTimeout = Timeout.connectTimeout as Duration?;
    // _authDio.options.connectTimeout = Timeout.connectTimeout as Duration?;
    // _dio.options.receiveTimeout = Timeout.receiveTimeout as Duration?;
    // _authDio.options.receiveTimeout = Timeout.receiveTimeout as Duration?;
    if (!kReleaseMode) {
      _dio.interceptors.add(LoggingInterceptor());
      _authDio.interceptors.add(LoggingInterceptor());
    }
  }

  /// This method is used to set api client.
  Future<void> setApiClient() async {
    authClient = ApiClient(await getApiClient(_authDio,
        baseUrl: "https://${AppConfig.apiEnvironment}"));
    client = ApiClient(await getApiClient(_dio));
  }
}
