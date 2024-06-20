import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/constants/assets.dart';
import 'package:glive/modules/login/login_view.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/commonFunctions.dart';
import 'package:glive/utils/globalVariables.dart';
import 'package:simple_shadow/simple_shadow.dart';

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
        Get.offNamed(RouteNames.home);
      } else {
        Get.offNamed(RouteNames.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleShadow(
              opacity: 0.25, // Default: 0.5
              color: Colors.grey, // Default: Black
              offset: const Offset(1, 1), // Default: Offset(2, 2)
              sigma: 7,
              child: Image.asset(
                Assets.icon,
                height: 100,
                width: 100,
              ), // Default: 2
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "GLive",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
