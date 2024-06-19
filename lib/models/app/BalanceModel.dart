// To parse this JSON data, do
//
//     final balanceModel = balanceModelFromJson(jsonString);

import 'dart:convert';

BalanceModel balanceModelFromJson(String str) => BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel {
    double funds;
    double donated;

    BalanceModel({
        required this.funds,
        required this.donated,
    });

    factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        funds: json["funds"],
        donated: json["donated"],
    );

    Map<String, dynamic> toJson() => {
        "funds": funds,
        "donated": donated,
    };
}
