// To parse this JSON data, do
//
//     final unsyncedResponse = unsyncedResponseFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:glive/models/database/AdminModel.dart';
import 'package:glive/models/database/FundModel.dart';
import 'package:glive/models/database/TransactionModel.dart';
import 'package:glive/models/database/UserModel.dart';

UnsyncedResponse unsyncedResponseFromJson(String str) => UnsyncedResponse.fromJson(json.decode(str));

String unsyncedResponseToJson(UnsyncedResponse data) => json.encode(data.toJson());

class UnsyncedResponse {
  List<TransactionModel>? transactions;
  List<UserModel>? users;
  List<FundModel>? funds;
  List<AdminModel>? admins;

  UnsyncedResponse({
    this.transactions,
    this.users,
    this.funds,
    this.admins,
  });

  factory UnsyncedResponse.fromJson(Map<String, dynamic> json) => UnsyncedResponse(
        transactions: json["transactions"] == null ? [] : List<TransactionModel>.from(json["transactions"]!.map((x) => TransactionModel.fromJson(x))),
        users: json["users"] == null ? [] : List<UserModel>.from(json["users"]!.map((x) => UserModel.fromJson(x))),
        funds: json["funds"] == null ? [] : List<FundModel>.from(json["funds"]!.map((x) => FundModel.fromJson(x))),
        admins: json["admins"] == null ? [] : List<AdminModel>.from(json["admins"]!.map((x) => AdminModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "funds": funds == null ? [] : List<dynamic>.from(funds!.map((x) => x.toJson())),
        "admins": admins == null ? [] : List<dynamic>.from(admins!.map((x) => x.toJson())),
      };
}
