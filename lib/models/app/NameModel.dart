// To parse this JSON data, do
//
//     final nameModel = nameModelFromJson(jsonString);

import 'dart:convert';

NameModel nameModelFromJson(String str) => NameModel.fromJson(json.decode(str));

String nameModelToJson(NameModel data) => json.encode(data.toJson());

class NameModel {
    String firstName;
    String lastName;
    String middleName;

    NameModel({
        required this.firstName,
        required this.lastName,
        required this.middleName,
    });

    factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
    };
}
