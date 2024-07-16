import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:glive/database/appDatabase.dart';
import 'package:http/http.dart' as http;

import 'package:glive/network/AuthInterceptor.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/globalVariables.dart';
import 'package:glive/utils/localStorage.dart';
import 'package:glive/utils/toastHelper.dart';

class NetworkProvider {
  late Dio _dio;

  final Duration _requestTimeout = const Duration(minutes: 2);

  NetworkProvider() {
    final options = BaseOptions(
      connectTimeout: _requestTimeout,
      receiveTimeout: _requestTimeout,
      contentType: 'application/json',
    );

    _dio = Dio(options);

    _dio.interceptors.add(AuthInterceptor());
  }

  // End Auth Module API

  static void checkAPIError(String errorMessage) {
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (errorMessage.toString().toLowerCase().contains("invalid admin")) {
        if (GlobalVariables.navigatorKey.currentContext != null) {
          await AppDatabase.reset();
          await LocalStorage.deleteAll();

          Navigator.pushNamedAndRemoveUntil(
            GlobalVariables.navigatorKey.currentContext!,
            RouteNames.login,
            (Route<dynamic> route) => false,
          );
        }
      }
    });
  }

  Future<String> get(String uri, [Map<String, dynamic>? params]) async {
    try {
      final Response<String> response = await _dio.get(
        uri,
        options: Options(responseType: ResponseType.plain),
      );
      log("GET response -->  $uri --- > $response");
      return response.data ?? "";
    } on DioException catch (e) {
      try {
        Map errorMap = jsonDecode(e.response.toString());
        String errorMessage = errorMap["error"]["message"];
        ToastHelper.error(errorMessage);
        checkAPIError(errorMessage);

        log("GET Error: ${e.response}");
      } catch (_) {}
      return "";
    }
  }

  Future<String> post(String uri,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    try {
      log("POST >>> $uri");
      Response<String> response = await _dio.post(
        uri,
        data: body,
        queryParameters: queryParams,
        options: Options(responseType: ResponseType.plain),
      );

      return response.data ?? "";
    } on DioException catch (e) {
      // log("post error ${uri} --> $e");
      try {
        Map errorMap = jsonDecode(e.response.toString());
        String errorMessage = errorMap["error"]["message"];
        ToastHelper.error(errorMessage);
        checkAPIError(errorMessage);

        log("POST Error: ${e.response}");
      } catch (_) {}
      return "";
    }
  }

  Future<String> setpassword(String uri,
      {dynamic body, Map<String, dynamic>? queryParams, String? token}) async {
    print("Token: $token");
    try {
      log("POST >>> $uri");
      log("Body: $body");
      log("Query Params: $queryParams");
      log("Headers: Authorization: Bearer $token");

      Response<String> response = await _dio.post(
        uri,
        data: body,
        queryParameters: queryParams,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data ?? "";
    } on DioException catch (e) {
      print("DioException: $e");
      if (e.response != null) {
        print("Response Status Code: ${e.response?.statusCode}");
        print("Response Data: ${e.response?.data}");
      }
      // log("post error ${uri} --> $e");
      try {
        Map errorMap = jsonDecode(e.response.toString());
        String errorMessage = errorMap["error"]["message"];
        ToastHelper.error(errorMessage);
        checkAPIError(errorMessage);

        log("POST Error: ${e.response}");
      } catch (e) {
        print("Error decoding response: $e");
      }
      return "";
    }
  }

  Future<String> putImage(String uri,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    try {
      Response<String> response = await _dio.put(
        uri,
        data: body,
        queryParameters: queryParams,
        options: Options(responseType: ResponseType.plain),
      );

      return response.data ?? "";
    } catch (e) {
      log("putImage error --> $e");
      return "";
    }
  }

  Future<String> put(String uri,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    // if (body != null) {
    //   log("PUT >>> $uri\n\nBody: ${jsonEncode(body.toJson())}");
    // } else {
    //   log("PUT >>> $uri");
    // }

    try {
      final Response<String> response = await _dio.put(
        uri,
        data: body,
        queryParameters: queryParams,
        options: Options(responseType: ResponseType.plain),
      );
      return response.data ?? "";
    } on DioException catch (e) {
      try {
        Map errorMap = jsonDecode(e.response.toString());
        String errorMessage = errorMap["error"]["message"];
        ToastHelper.error(errorMessage);
        checkAPIError(errorMessage);
      } catch (_) {}
      return "";
    }
  }

  Future<String> patch(String uri,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    // if (body != null) {
    //   log("PUT >>> $uri\n\nBody: ${jsonEncode(body.toJson())}");
    // } else {
    //   log("PUT >>> $uri");
    // }

    try {
      final Response<String> response = await _dio.patch(
        uri,
        data: body,
        queryParameters: queryParams,
        options: Options(responseType: ResponseType.plain),
      );
      return response.data ?? "";
    } on DioException catch (e) {
      try {
        Map errorMap = jsonDecode(e.response.toString());
        String errorMessage = errorMap["error"]["message"];
        ToastHelper.error(errorMessage);
        checkAPIError(errorMessage);
      } catch (_) {}
      return "";
    }
  }

  Future<String> delete(String uri,
      {Object? body, Map<String, dynamic>? queryParams}) async {
    CancelToken? cancelToken;
    try {
      final Response<String> response = await _dio.delete(
        uri,
        data: jsonEncode(body),
        queryParameters: queryParams,
        options: Options(
          responseType: ResponseType.plain,
        ),
        cancelToken: cancelToken,
      );
      log("delete success --> ${response.data}");
      return response.data ?? "";
    } catch (e) {
      log("delete error --> $e");
      return "";
    }
  }

  Future<String> upload(
    String uri, {
    FormData? formData,
    Map<String, dynamic>? queryParams,
    Function(int sent, int total)? onSendProgress,
  }) async {
    final Response<String> response = await _dio.post(
      uri,
      data: formData,
      queryParameters: queryParams,
      options: Options(responseType: ResponseType.plain),
      onSendProgress: (int sent, int total) {
        if (onSendProgress == null) {
          return;
        }
        onSendProgress(sent, total);
      },
    );
    return response.data ?? '';
  }
}
