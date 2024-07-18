import 'package:flutter/material.dart';
import 'package:glive/modules/chats/chat_screen.dart';
import 'package:glive/modules/forgot_password/forgotpassword_view.dart';

import 'package:glive/modules/home/home_view.dart';
import 'package:glive/modules/login/initial_login_view.dart';
import 'package:glive/modules/login/login_view.dart';
import 'package:glive/modules/profile/creator_center_view.dart';
import 'package:glive/modules/security/channels_view.dart';
import 'package:glive/modules/security/faceid_setup_view.dart';
import 'package:glive/modules/security/faceid_view.dart';
import 'package:glive/modules/security/fingerprint_view.dart';
import 'package:glive/modules/security/otp_view.dart';
import 'package:glive/modules/signup/signup_view.dart';
import 'package:glive/modules/signup/tabs/terms_page.dart';

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
  static const String initiallogin = "/initiallogin";
  static const String security = "/security";
  static const String fingerprint = "/fingerprint";
  static const String faceid = "/faceid";
  static const String faceidsetup = "/faceidsetup";
  static const String channels = "/channels";
  static const String signup = "/signup";
  static const String chat = "/chat";
  static const String creatorcenter = "/creatorcenter";
  static const String forgotpassword = "/forgotpassword";
  static const String termspage = "/termspage";
}

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.splash: (context) => const SplashView(),
    RouteNames.login: (context) => const LoginView(),
    RouteNames.home: (context) => const HomeView(),
    RouteNames.initiallogin: (context) => const InitialLoginView(),
    RouteNames.security: (context) => const OTPView(),
    RouteNames.fingerprint: (context) => const FingerprintView(),
    RouteNames.faceid: (context) => const FaceIDView(),
    RouteNames.faceidsetup: (context) => const FaceIDSetupView(),
    RouteNames.channels: (context) => const ChannelsView(),
    RouteNames.signup: (context) => const SignupView(),
    RouteNames.chat: (context) => const ChatScreen(),
    RouteNames.creatorcenter: (context) => const CreatorCenterView(),
    RouteNames.forgotpassword: (context) => const ForgotPasswordView(),
    RouteNames.termspage: (context) => const TermsPage(),
  };
}
