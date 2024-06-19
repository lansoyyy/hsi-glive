import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:glive/constants/StorageCodes.dart';

import 'package:glive/utils/localStorage.dart';

class AuthInterceptor extends Interceptor {
  static const String authHeader = "Authorization";
  static const String sessionExpirationTime = "X-NX-Session-Expiration-Time";

  late Dio interceptorDio;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String authToken = await LocalStorage.readString(StorageCodes.token);

    options.headers = {...options.headers, authHeader: 'Bearer $authToken'};
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
