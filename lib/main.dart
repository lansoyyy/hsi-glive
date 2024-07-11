import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
import 'package:glive/modules/splash/splash_view.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/MeasureSize.dart';
import 'package:oktoast/oktoast.dart';

bool isTablet(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final aspectRatio = mediaQuery.size.aspectRatio;
  log("Aspect: ${aspectRatio}");
  final isTablet = aspectRatio < 1.6 && aspectRatio > 0.7;
  return isTablet;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(isTablet(context) ? 600 : 428, 984),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MeasureSize(
            onChange: (size) {
              GlobalVariables.height = size.height;
              GlobalVariables.width = size.width;
              setState(() {});
            },
            child: OKToast(
              child: GetMaterialApp(
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
                getPages: [
                  GetPage(name: '/', page: () => const SplashView()),
                  GetPage(name: '/signup', page: () => const SignupView()),
                  GetPage(name: '/login', page: () => const LoginView()),
                  GetPage(
                      name: '/initiallogin',
                      page: () => const InitialLoginView()),
                  GetPage(name: '/home', page: () => const HomeView()),
                  GetPage(name: '/security', page: () => const OTPView()),
                  GetPage(
                      name: '/fingerprint',
                      page: () => const FingerprintView()),
                  GetPage(name: '/faceid', page: () => const FaceIDView()),
                  GetPage(
                      name: '/faceidsetup',
                      page: () => const FaceIDSetupView()),
                  GetPage(name: '/channels', page: () => const ChannelsView()),
                  GetPage(name: '/chat', page: () => const ChatScreen()),
                  GetPage(
                      name: '/creatorcenter',
                      page: () => const CreatorCenterView()),
                  GetPage(
                      name: '/forgotpassword',
                      page: () => const ForgotPasswordView()),
                ],
                title: 'GLive',
              ),
            ),
          );
        },
        child: const SplashView());
  }
}
