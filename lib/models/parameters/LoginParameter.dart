// To parse this JSON data, do
//
//     final loginParameter = loginParameterFromJson(jsonString);

import 'dart:convert';

LoginParameter loginParameterFromJson(String str) => LoginParameter.fromJson(json.decode(str));

String loginParameterToJson(LoginParameter data) => json.encode(data.toJson());

class LoginParameter {
    String? username;
    String? password;

    LoginParameter({
        this.username,
        this.password,
    });

    factory LoginParameter.fromJson(Map<String, dynamic> json) => LoginParameter(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}
