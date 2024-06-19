import 'package:flutter/cupertino.dart';
import 'package:glive/models/database/AdminModel.dart';

class GlobalVariables {
  static double width = 0.0;
  static double height = 0.0;
  static int totalFunds = 0;
  static int donated = 0;
  static String notes = "";
  static late AdminModel currentUser;
  static bool isUserReady = false;
  static late GlobalKey<NavigatorState> navigatorKey;
}

double widthScreen() {
  return GlobalVariables.width;
}

double heightScreen() {
  return GlobalVariables.height;
}
