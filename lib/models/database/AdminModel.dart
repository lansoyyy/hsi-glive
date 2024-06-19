// To parse this JSON data, do
//
//     final adminModel = adminModelFromJson(jsonString);

import 'dart:convert';

import 'package:glive/utils/commonFunctions.dart';

AdminModel adminModelFromJson(String str) =>
    AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  String id;
  String firstName;
  String lastName;
  String username;
  String password;
  String createdAt;
  String parentId;

  String userType; //super-admin, branch-admin
  /**
   * Super admin will have all the records
   * 
   * Branch-admins can have all the records from its children admins
   * 
   * Admins can have all the records within them only
   *  
   */

  String permissions;
  String fundsId; //yes or empty

  String syncedAt;
  String deletedAt;

  AdminModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.parentId,
    required this.userType,
    required this.permissions,
    required this.fundsId,
    required this.syncedAt,
    required this.deletedAt,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        username: json["username"] ?? "",
        password: json["password"] ?? "",
        createdAt: json["createdAt"] ?? "",
        parentId: json["parentId"] ?? "",
        userType: json["userType"] ?? "",
        permissions: json["permissions"] ?? "",
        fundsId: json["fundsId"] ?? "",
        syncedAt: json["syncedAt"] ?? "",
        deletedAt: json["deletedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
        "userType": userType,
        "permissions": permissions,
        "fundsId": fundsId,
        "parentId": parentId,
        "createdAt": createdAt,
        "syncedAt": syncedAt,
        "deletedAt": deletedAt,
      };
}
