// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:glive/models/app/ageGenderModel.dart';
import 'package:glive/models/app/NameModel.dart';

void appGoBack(BuildContext context, String optionalRoute) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    Navigator.pushReplacementNamed(context, optionalRoute);
  }
}

NameModel formatName(String unformattedName) {
  List<String> parts = unformattedName.trim().split(RegExp(r'[\s,]+'));

  if (parts.length == 1) {
    return NameModel(firstName: "", lastName: parts[0], middleName: "");
  } else if (parts.length == 2) {
    return NameModel(firstName: parts[0], lastName: parts[1], middleName: "");
  } else if (parts.length == 3) {
    return NameModel(firstName: parts[0], middleName: parts[1], lastName: parts[2]);
  } else {
    String firstName = parts.first;
    String lastName = parts.last;
    String middleName = parts.sublist(1, parts.length - 1).join(" ");
    return NameModel(firstName: firstName, lastName: lastName, middleName: middleName);
  }
}

AgeGenderModel getAgeGender(String ageGender) {
  if (ageGender.isEmpty) {
    return AgeGenderModel(age: 0, gender: "M");
  }

  int age = int.parse(ageGender.replaceAll(RegExp(r'[^0-9]'), ''));
  String gender = ageGender.replaceAll(RegExp(r'[0-9]'), '');

  return AgeGenderModel(age: age, gender: gender);
}

String formatBirthDate(String no, String bday, AgeGenderModel ageGenderModel) {
  List<String> parts = bday.split(RegExp(r'[-/]'));
  int day = 1;
  int month = 1;
  int year = DateTime.now().year;
  // If year is provided

  if (parts.length == 3) {
    if (parts[0].length == 4) {
      //[1989, 12, 04T00:00:00.000Z]
      day = int.parse(getFirstTwoCharacters(parts[2]));
      month = int.parse(parts[1]);
      year = int.parse(parts[0]);
    } else if (parts[2].length == 4) {
      //[08, 24, 1973]
      day = int.parse(parts[1]);
      month = int.parse(parts[0]);
      year = int.parse(parts[2]);
    }
  }
  DateTime birthday = DateTime(year, month, day);
  String formattedBirthday = "${birthday.year}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}";

  return formattedBirthday;
}

String getFirstTwoCharacters(String input) {
  if (input.length < 2) {
    return input; // If the input string has less than 2 characters, return it as is
  }
  return input.substring(0, 2); // Get the substring from index 0 to 2 (exclusive)
}
/* 

  Map<String, int> monthMap = {
    "jan": 1,
    "feb": 2,
    "mar": 3,
    "apr": 4,
    "may": 5,
    "jun": 6,
    "jul": 7,
    "aug": 8,
    "sep": 9,
    "oct": 10,
    "nov": 11,
    "dec": 12
  };
 */