// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  String id;
  String userId;
  String adminId;
  String fundsId;
  String createdAt;
  String name;
  String precint;
  String amount;
  String reason;
  String status;
  String proof;
  String metadata;
  String syncedAt;
  String deletedAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.fundsId,
    required this.createdAt,
    required this.amount,
    required this.name,
    required this.precint,
    required this.reason,
    required this.status,
    required this.proof,
    required this.metadata,
    required this.syncedAt,
    required this.deletedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json["id"] ?? "",
        userId: json["userId"] ?? "",
        adminId: json["adminId"] ?? "",
        fundsId: json["fundsId"] ?? "",
        createdAt: json["createdAt"] ?? "",
        amount: json["amount"] ?? "",
        name: json["name"] ?? "",
        precint: json["precint"] ?? "",
        reason: json["reason"] ?? "",
        status: json["status"] ?? "",
        proof: json["proof"] ?? "",
        metadata: json["metadata"] ?? "",
        syncedAt: json["syncedAt"] ?? "",
        deletedAt: json["deletedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "adminId": adminId,
        "fundsId": fundsId,
        "createdAt": createdAt,
        "amount": amount,
        "name": name,
        "precint": precint,
        "reason": reason,
        "proof": proof,
        "status": status,
        "metadata": metadata,
        "syncedAt": syncedAt,
        "deletedAt": deletedAt,
      };
}
