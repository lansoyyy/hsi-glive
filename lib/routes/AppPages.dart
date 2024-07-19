// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:glive/modules/chats/views/chat_view.dart';
import 'package:glive/modules/create_post/tabs/post_camera_page.dart';
import 'package:glive/modules/create_post/views/media_post_view.dart';
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
import 'package:glive/modules/splash/splash_view.dart';
import 'package:glive/routes/AppRoutes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashView()),
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginView()),
    GetPage(name: AppRoutes.INITIALLOGIN, page: () => const InitialLoginView()),
    GetPage(name: AppRoutes.HOME, page: () => const HomeView()),
    GetPage(name: AppRoutes.OTP, page: () => const OTPView()),
    GetPage(name: AppRoutes.FORGOTPASSWORD, page: () => const ForgotPasswordView()),
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
    GetPage(name: AppRoutes.MEDIAPOST, page: () => MediaPostView()),
    GetPage(name: AppRoutes.POSTCAMERA, page: () => PostCameraPage()),
    GetPage(name: AppRoutes.CHAT, page: () => const ChatScreen()),
    GetPage(name: AppRoutes.CREATORCENTER, page: () => const CreatorCenterView()),
  ];
}
