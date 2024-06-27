import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/routes.dart';
import 'package:glive/services/auth_service.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:local_auth/local_auth.dart';

import '../../widgets/ButtonWidget.dart';

class FingerprintView extends StatefulWidget {
  const FingerprintView({super.key});

  @override
  State<FingerprintView> createState() => _FingerprintViewState();
}

class _FingerprintViewState extends State<FingerprintView> {
  final AuthenticationService authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100.sp,
            ),
            TextWidget(
              text: 'Set your Fingerprint',
              fontSize: 25.sp,
              color: Colors.black,
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextWidget(
              text:
                  'Add a fingerprint number to make your\naccount more secure',
              fontSize: 15.sp,
              color: Colors.black,
            ),
            SizedBox(
              height: 100.sp,
            ),
            Image.asset(
              'assets/images/Vector (1).png',
              height: 203.sp,
              width: 209.sp,
            ),
            SizedBox(
              height: 200.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  width: 175.sp,
                  textColor: Colors.white,
                  color: Colors.grey,
                  label: 'Skip',
                  onPressed: () {
                    // // Collect OTP from the controllers and perform verification
                    // String otp =
                    //     _controllers.map((controller) => controller.text).join();
                    // print("Entered OTP: $otp");

                    Get.toNamed(RouteNames.faceid);
                  },
                ),
                ButtonWidget(
                  width: 175.sp,
                  textColor: Colors.white,
                  color: const Color(0XFF0A9AAA),
                  label: 'Confirm',
                  onPressed: () async {
                    // authchack(context);

                    authService.authchack(context, RouteNames.faceid);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
