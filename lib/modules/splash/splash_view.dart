import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/routes/AppRoutes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      if (box.read('started') == 'true') {
        Get.offNamed(AppRoutes.HOME);
      } else {
        Get.offNamed(AppRoutes.INITIALLOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/splash_bg.png',
              ),
            ),
          ),
          child: Center(
            child: Image.asset(
              height: 186,
              'assets/images/logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
