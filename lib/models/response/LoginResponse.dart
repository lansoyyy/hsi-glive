// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:glive/models/database/AdminModel.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? token;
  AdminModel? user;

  LoginResponse({
    this.token,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        user: json["user"] == null ? null : AdminModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}
