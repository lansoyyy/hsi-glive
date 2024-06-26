// To parse this JSON data, do
//
//     final ageGenderModel = ageGenderModelFromJson(jsonString);

// ignore_for_file: file_names, duplicate_ignore

import 'dart:convert';

AgeGenderModel ageGenderModelFromJson(String str) => AgeGenderModel.fromJson(json.decode(str));

String ageGenderModelToJson(AgeGenderModel data) => json.encode(data.toJson());

class AgeGenderModel {
  int age;
  String gender;

  AgeGenderModel({
    required this.age,
    required this.gender,
  });

  factory AgeGenderModel.fromJson(Map<String, dynamic> json) => AgeGenderModel(
        age: json["age"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "gender": gender,
      };
}
