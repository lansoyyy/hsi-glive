import 'package:flutter/material.dart';

import 'package:glive/modules/home/home_view.dart';
import 'package:glive/modules/login/login_view.dart';

import 'package:glive/modules/splash/splash_view.dart';

class RouteNames {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String home = "/home";
  static const String admins = "/admins";
  static const String branchAdmin = "/branchAdmin";
  static const String digitalIds = "/digital-ids";
  static const String cashHistory = "/cash-history";
  static const String manageAdmin = "/manage-admin";
  static const String manageDigitalId = "/manage-digital-id";
  static const String disbursementScanner = "/qr-scanner";
  static const String disburseUser = "/disburse-user";
  static const String manageCashItem = "/manage-cash-item";
  static const String reports = "/reports";
  static const String donationHistory = "/donation-history";
  static const String fundHistory = "/fund-history";
  static const String allLogs = "/logs";
}

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.splash: (context) => const SplashView(),
    RouteNames.login: (context) => const LoginView(),
    RouteNames.home: (context) => const HomeView(),
  };
}
