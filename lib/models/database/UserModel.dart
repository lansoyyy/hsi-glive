// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String adminId;
  String firstName;
  String lastName;
  String middleName;
  String address;
  String birthDate;
  String precint;
  String mobile;
  String gender;
  String image;
  String imageName;
  String createdAt;
  String syncedAt; //only in mobile, used if failed in syncing to online database
  String deletedAt;

  UserModel({
    required this.id,
    required this.adminId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.address,
    required this.birthDate,
    required this.precint,
    required this.mobile,
    required this.gender,
    required this.image,
    required this.imageName,
    required this.createdAt,
    required this.syncedAt,
    required this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? "",
        adminId: json["adminId"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        middleName: json["middleName"] ?? "",
        address: json["address"] ?? "",
        birthDate: json["birthDate"] ?? "",
        precint: json["precint"] ?? "",
        mobile: json["mobile"] ?? "",
        gender: json["gender"] ?? "",
        image: json["image"] ?? "",
        imageName: json["imageName"] ?? "",
        createdAt: json["createdAt"] ?? "",
        syncedAt: json["syncedAt"] ?? "",
        deletedAt: json["deletedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "address": address,
        "birthDate": birthDate,
        "precint": precint,
        "mobile": mobile,
        "gender": gender,
        "image": image,
        "imageName": imageName,
        "createdAt": createdAt,
        "syncedAt": syncedAt,
        "deletedAt": deletedAt,
      };
}
