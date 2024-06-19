// To parse this JSON data, do
//
//     final fundModel = fundModelFromJson(jsonString);

import 'dart:convert';

import 'package:glive/utils/commonFunctions.dart';

FundModel fundModelFromJson(String str) => FundModel.fromJson(json.decode(str));

String fundModelToJson(FundModel data) => json.encode(data.toJson());

class FundModel {
  String id;
  String fundsId;
  String adminId;
  String type;
  String amount;
  String syncedAt;
  String deletedAt;
  String createdAt;

  FundModel({
    required this.id,
    required this.fundsId,
    required this.adminId,
    required this.type,
    required this.amount,
    required this.syncedAt,
    required this.deletedAt,
    required this.createdAt,
  });

  factory FundModel.fromJson(Map<String, dynamic> json) => FundModel(
        id: json["id"] ?? "",
        fundsId: json["fundsId"] ?? "",
        adminId: json["adminId"] ?? "",
        type: json["type"] ?? "",
        amount: json["amount"] ?? "",
        syncedAt: json["syncedAt"] ?? "",
        deletedAt: json["deletedAt"] ?? "",
        createdAt: json["createdAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fundsId": fundsId,
        "adminId": adminId,
        "type": type,
        "amount": amount,
        "syncedAt": syncedAt,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
      };
}
