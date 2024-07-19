import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InitialLoginView extends StatefulWidget {
  const InitialLoginView({super.key});

  @override
  State<InitialLoginView> createState() => _InitialLoginViewState();
}

class _InitialLoginViewState extends State<InitialLoginView> {
  bool isChecked = false;

  List socialMediaImages = ['facebook', 'instagram', 'google', 'tiktok'];

  List socialMedias = ['Facebook', 'Instagram', 'Google', 'Tiktok'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.50,
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/login_bg.png',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: 186,
              'assets/images/logo.png',
            ),
            SizedBox(
              height: 5.sp,
            ),
            TextWidget(
              text: 'Log in to Unlock Best Experience!',
              fontSize: 18.sp,
              color: Colors.white,
            ),
            SizedBox(
              height: 20.sp,
            ),
            for (int i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    Get.offNamed(AppRoutes.LOGIN);
                  },
                  child: Container(
                    width: 350.sp,
                    height: 60.sp,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.30),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 0.30),
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/${socialMediaImages[i]}.png',
                          height: 30.sp,
                          width: 30.sp,
                        ),
                        SizedBox(
                          width: 20.sp,
                        ),
                        TextWidget(
                          text: 'Continue with ${socialMedias[i]}',
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 25.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 125.sp,
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                TextWidget(
                  text: 'or',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.sp,
                ),
                SizedBox(
                  width: 125.sp,
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            ButtonWidget(
              label: 'Sign In',
              onPressed: () {
                Get.offNamed(AppRoutes.LOGIN);
              },
            ),
            SizedBox(
              height: 50.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Don’t have an aSSccount?',
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: 'Sign up',
                    fontSize: 16.sp,
                    color: const Color(0XFF85ECF8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
