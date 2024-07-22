import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/services/auth_service.dart';
import 'package:glive/widgets/TextWidget.dart';

import '../../widgets/ButtonWidget.dart';

class FaceIDView extends StatefulWidget {
  const FaceIDView({super.key});

  @override
  State<FaceIDView> createState() => _FaceIDViewState();
}

class _FaceIDViewState extends State<FaceIDView> {
  final AuthenticationService authService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            text: 'Set your Face ID',
            fontSize: 25.sp,
            color: Colors.black,
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextWidget(
            text: 'Add a face id number to make your\naccount more secure',
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
          ButtonWidget(
            textColor: Colors.white,
            color: const Color(0XFF0A9AAA),
            label: 'Scan',
            onPressed: () {
              // // Collect OTP from the controllers and perform verification
              // String otp =
              //     _controllers.map((controller) => controller.text).join();
              // print("Entered OTP: $otp");

              authService.authchack(context, AppRoutes.FACEIDSETUP);
            },
          ),
          SizedBox(
            height: 20.sp,
          ),
        ],
      ),
    );
  }
}
