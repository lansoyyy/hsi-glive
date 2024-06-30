import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:glive/widgets/AppPasswordInput.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';

class PasswordTab extends StatefulWidget {
  const PasswordTab({super.key});

  @override
  State<PasswordTab> createState() => _PasswordTabState();
}

class _PasswordTabState extends State<PasswordTab> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.sp,
            ),
            Center(
              child: TextWidget(
                text: 'Create Password',
                fontSize: 30.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Center(
              child: TextWidget(
                text: 'Create your password',
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 50.sp,
            ),
            Center(
              child: AppPasswordInput(width: 350.sp, title: "Password", controller: password, icon: Icons.lock),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Center(
              child: AppPasswordInput(width: 350.sp, title: "Confirm Password", controller: confirmpassword, icon: Icons.lock),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Center(
              child: ButtonWidget(
                height: 55,
                radius: 10,
                width: 350.sp,
                label: 'Save Password',
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Your password must have:',
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      TextWidget(
                        text: '8 to 20 characters',
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      TextWidget(
                        text: 'Letters, numbers and special characters',
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
