import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/modules/home/home_view.dart';
import 'package:glive/modules/login/login_view.dart';
import 'package:glive/modules/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/home', page: () => const HomeView()),
      ],
      title: 'GLive',
    );
  }
}
