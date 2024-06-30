// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:glive/modules/home/home_view.dart';
import 'package:glive/modules/login/initial_login_view.dart';
import 'package:glive/modules/login/login_view.dart';
import 'package:glive/modules/security/channels_view.dart';
import 'package:glive/modules/security/faceid_setup_view.dart';
import 'package:glive/modules/security/faceid_view.dart';
import 'package:glive/modules/security/fingerprint_view.dart';
import 'package:glive/modules/security/otp_view.dart';
import 'package:glive/modules/signup/signup_view.dart';
import 'package:glive/modules/splash/splash_view.dart';
import 'package:glive/routes/AppRoutes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashView()),
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginView()),
    GetPage(name: AppRoutes.INITIALLOGIN, page: () => const InitialLoginView()),
    GetPage(name: AppRoutes.HOME, page: () => const HomeView()),
    GetPage(name: AppRoutes.OTP, page: () => const OTPView()),
    GetPage(name: AppRoutes.FINGERPRINT, page: () => const FingerprintView()),
    GetPage(name: AppRoutes.FACEID, page: () => const FaceIDView()),
    GetPage(name: AppRoutes.FACEIDSETUP, page: () => const FaceIDSetupView()),
    GetPage(name: AppRoutes.CHANNELS, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.ADMINS, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.BRANCHADMIN, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.DIGITALAIDS, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.CASHHISTORY, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.MANAGEADMIN, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.MANAGEDIGITALID, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.QRSCANNER, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.DISBURSEUSER, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.MANAGECASHITEM, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.REPORTS, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.DONATIONHISTORY, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.FUNDHISTORY, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.ALLLOGS, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.SECURITY, page: () => const ChannelsView()),
    GetPage(name: AppRoutes.SIGNUP, page: () => const SignupView()),
  ];
}
