// To parse this JSON data, do
//
//     final loginParameter = loginParameterFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

LoginParameter loginParameterFromJson(String str) => LoginParameter.fromJson(json.decode(str));

String loginParameterToJson(LoginParameter data) => json.encode(data.toJson());

class LoginParameter {
  String? email;
  String? password;

  LoginParameter({
    this.email,
    this.password,
  });

  factory LoginParameter.fromJson(Map<String, dynamic> json) => LoginParameter(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
