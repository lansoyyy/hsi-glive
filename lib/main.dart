import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/home/home_view.dart';
import 'package:glive/modules/login/login_view.dart';
import 'package:glive/modules/splash/splash_view.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return OKToast(
            child: GetMaterialApp(
              initialRoute: '/',
              getPages: [
                GetPage(name: '/', page: () => const SplashView()),
                GetPage(name: '/login', page: () => const LoginView()),
                GetPage(name: '/home', page: () => const HomeView()),
              ],
              title: 'GLive',
            ),
          );
        },
        child: const SplashView());
  }
}
