import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/widgets/AppTextInput.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';

class ForgotPasswordEmailTab extends StatefulWidget {
  const ForgotPasswordEmailTab({super.key});

  @override
  State<ForgotPasswordEmailTab> createState() => _ForgotPasswordEmailTabState();
}

class _ForgotPasswordEmailTabState extends State<ForgotPasswordEmailTab> {
  TextEditingController emailController = TextEditingController();

  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    return isVerified
        ? verifiedWidget()
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.sp,
                ),
                TextWidget(
                  text: 'Verify Account',
                  fontSize: 30.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                TextWidget(
                  text:
                      'Please enter your email address to get\na link to change your password.',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 50.sp,
                ),
                AppTextInput(
                  width: 350.sp,
                  title: 'Email Address',
                  controller: emailController,
                  icon: Icons.email,
                ),
                SizedBox(
                  height: 20.sp,
                ),
                ButtonWidget(
                  height: 55,
                  radius: 10,
                  width: 350.sp,
                  label: 'Continue',
                  onPressed: () {
                    setState(() {
                      isVerified = true;
                    });
                  },
                ),
                SizedBox(
                  height: 50.sp,
                ),
              ],
            ),
          );
  }

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  Widget verifiedWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.sp,
        ),
        TextWidget(
          text: 'Verify Account',
          fontSize: 30.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextWidget(
          text: 'Please enter the verification code\nsent to your email',
          fontSize: 12.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 50.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Container(
              width: 60.sp,
              height: 60.sp,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.30),
                border: Border.all(color: Colors.white, width: 0.30),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                onChanged: (value) => _onSubmit(value, index),
              ),
            );
          }),
        ),
        SizedBox(
          height: 20.sp,
        ),
        ButtonWidget(
          height: 55,
          radius: 10,
          width: 350.sp,
          label: 'Verify',
          onPressed: () {
            setState(() {
              forgotpasswordIndexPage++;
            });
          },
        ),
      ],
    );
  }

  void _onSubmit(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.length == 1 && index == 5) {
      _focusNodes[index].unfocus();
      // Perform OTP verification here
    }
  }
}
