// To parse this JSON data, do
//
//     final getAdminResponse = getAdminResponseFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:glive/models/database/UserModel.dart';

GetAdminResponse getAdminResponseFromJson(String str) => GetAdminResponse.fromJson(json.decode(str));

String getAdminResponseToJson(GetAdminResponse data) => json.encode(data.toJson());

class GetAdminResponse {
  int? c;
  String? m;
  List<UserModel>? d;

  GetAdminResponse({
    this.c,
    this.m,
    this.d,
  });

  factory GetAdminResponse.fromJson(Map<String, dynamic> json) => GetAdminResponse(
        c: json["c"],
        m: json["m"],
        d: json["d"] == null ? [] : List<UserModel>.from(json["d"]!.map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "c": c,
        "m": m,
        "d": d == null ? [] : List<dynamic>.from(d!.map((x) => x.toJson())),
      };
}
