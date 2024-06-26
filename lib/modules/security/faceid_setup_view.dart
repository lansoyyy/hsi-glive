import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/routes.dart';
import 'package:glive/widgets/TextWidget.dart';

import '../../widgets/ButtonWidget.dart';

class FaceIDSetupView extends StatelessWidget {
  const FaceIDSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: 'Face ID is now',
              fontSize: 25.sp,
              color: Colors.black,
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextWidget(
              text: 'Set up',
              fontSize: 25.sp,
              color: Colors.black,
            ),
            SizedBox(
              height: 100.sp,
            ),
            Image.asset(
              'assets/images/check.png',
              height: 203.sp,
              width: 209.sp,
            ),
            SizedBox(
              height: 250.sp,
            ),
            ButtonWidget(
              textColor: Colors.white,
              color: const Color(0XFF0A9AAA),
              label: 'Done',
              onPressed: () {
                // // Collect OTP from the controllers and perform verification
                // String otp =
                //     _controllers.map((controller) => controller.text).join();
                // print("Entered OTP: $otp");

                Get.offNamed(RouteNames.channels);
              },
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
