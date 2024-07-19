import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/ToastHelper.dart';
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

  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey2,
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
                child: AppPasswordInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                        return 'Password must contain at least one letter';
                      }
                      if (!RegExp(r'\d').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }

                      return null;
                    },
                    width: 350.sp,
                    title: "Password",
                    controller: password,
                    icon: Icons.lock),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Center(
                child: AppPasswordInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                        return 'Password must contain at least one letter';
                      }
                      if (!RegExp(r'\d').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }

                      return null;
                    },
                    width: 350.sp,
                    title: "Confirm Password",
                    controller: confirmpassword,
                    icon: Icons.lock),
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
                  onPressed: () {
                    if (password.text == confirmpassword.text) {
                      if (_formKey2.currentState!.validate()) {
                        setState(() {
                          registrationIndexPage++;
                        });
                      }
                    } else {
                      ToastHelper.error('Password do not match!');
                    }
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return Dialog(
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Image.asset(
                    //             'assets/images/hand.png',
                    //             height: 250.sp,
                    //             width: 250.sp,
                    //           ),
                    //           TextWidget(
                    //             text: 'Add a Referral Code?',
                    //             fontSize: 24.sp,
                    //           ),
                    //           SizedBox(
                    //             height: 10.sp,
                    //           ),
                    //           ButtonWidget(
                    //             width: 200,
                    //             radius: 15,
                    //             color: const Color(0XFF0A9AAA),
                    //             label: 'Yes',
                    //             textColor: Colors.white,
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //               setState(() {
                    //                 registrationIndexPage++;
                    //               });
                    //             },
                    //           ),
                    //           SizedBox(
                    //             height: 20.sp,
                    //           ),
                    //           ButtonWidget(
                    //             width: 200,
                    //             radius: 15,
                    //             color: Colors.white,
                    //             label: 'No',
                    //             onPressed: () {

                    //             },
                    //           ),
                    //           SizedBox(
                    //             height: 20.sp,
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // );
                  },
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
      ),
    );
  }
}
