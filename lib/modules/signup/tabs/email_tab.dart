import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/widgets/AppTextInput.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';

class EmailTab extends StatefulWidget {
  const EmailTab({super.key});

  @override
  State<EmailTab> createState() => _EmailTabState();
}

class _EmailTabState extends State<EmailTab> {
  TextEditingController emailController = TextEditingController();

  bool isVerified = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return isVerified
        ? verifiedWidget()
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.sp,
                ),
                TextWidget(
                  text: 'Sign Up',
                  fontSize: 30.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                TextWidget(
                  text: 'Sign up with your email address',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.sp,
                ),
                ButtonWidget(
                  height: 55,
                  radius: 10,
                  width: 350.sp,
                  label: 'Verify Email',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showVerificationDialog();
                      setState(() {
                        isVerified = true;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'Already have an account?',
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(RouteNames.login);
                      },
                      child: TextWidget(
                        text: 'Sign in',
                        fontSize: 14.sp,
                        color: AppColors.bluegreen,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.sp,
                ),
                TextWidget(
                  text: 'Or sign in using',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            Get.offNamed(RouteNames.security);
                          },
                          child: Container(
                            width: 55.sp,
                            height: 55.sp,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/${socialMediaImages[i]}.png',
                                height: 30.sp,
                                width: 30.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
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
                style: const TextStyle(
                  color: Colors.white,
                ),
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
              registrationIndexPage++;
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

      // Print all the values from the controllers
      String otp = _controllers.map((controller) => controller.text).join();
      print('Entered OTP: $otp');

      // Perform OTP verification here
    }
  }

  showVerificationDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/email_verification.png',
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  TextWidget(
                    text: '''
Verification Code
has been sent to your email
''',
                    fontSize: 14,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  const SpinKitCircle(
                    color: Color(0xFFC30FCC),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(seconds: 3),
    );

    Navigator.pop(context);
  }
}
