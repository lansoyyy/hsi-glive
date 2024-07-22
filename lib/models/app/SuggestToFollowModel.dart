// ignore_for_file: file_names

import 'dart:convert';

SuggestToFollowModel suggestToFollowModelFromJson(String str) => SuggestToFollowModel.fromJson(json.decode(str));

String suggestToFollowModelToJson(SuggestToFollowModel data) => json.encode(data.toJson());

class SuggestToFollowModel {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String email;
  final String phoneNumberPrefix;
  final String phoneNumber;

  SuggestToFollowModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.phoneNumberPrefix,
    required this.phoneNumber,
  });
  factory SuggestToFollowModel.fromJson(Map<String, dynamic> json) => suggestToFollowModelFromJson(json);

  Map<String, dynamic> toJson() => suggestToFollowModelToJson(this);

  static SuggestToFollowModel suggestToFollowModelFromJson(Map<String, dynamic> json) => SuggestToFollowModel(
        id: json["_id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumberPrefix: json["phoneNumberPrefix"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> suggestToFollowModelToJson(SuggestToFollowModel instance) => <String, dynamic>{
        "_id": instance.id,
        "firstName": instance.firstName,
        "middleName": instance.middleName,
        "lastName": instance.lastName,
        "fullName": instance.fullName,
        "email": instance.email,
        "phoneNumberPrefix": instance.phoneNumberPrefix,
        "phoneNumber": instance.phoneNumber,
      };
  List<Object> get props => [
        id,
        firstName,
        middleName,
        lastName,
        email,
        phoneNumberPrefix,
        phoneNumber,
      ];
}
