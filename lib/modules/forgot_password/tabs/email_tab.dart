// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/LoadingUtil.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

class ForgotPasswordEmailTab extends StatefulWidget {
  const ForgotPasswordEmailTab({super.key});

  @override
  State<ForgotPasswordEmailTab> createState() => _ForgotPasswordEmailTabState();
}

class _ForgotPasswordEmailTabState extends State<ForgotPasswordEmailTab> {
  TextEditingController emailController = TextEditingController();

  bool isVerified = false;

  final _formKey1 = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                Text(
                  "Verify Account",
                  style: TextStyle(color: Colors.white, fontSize: 28.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextWidget(
                  text: 'Please enter your email address to get\na link to change your password.',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 50.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 68.sp,
                        width: widthScreen(),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.sp, color: emailError.isNotEmpty ? Colors.red : HexColor("#5A5A5A")),
                            borderRadius: BorderRadius.circular(10.sp),
                            color: Colors.white.withOpacity(0.10)),
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(color: HexColor("#989898"), fontSize: 12.sp, fontWeight: FontWeight.w400),
                            ),
                            TextFormField(
                              controller: emailController,
                              style: TextStyle(color: Colors.white, fontSize: 15.sp),
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(color: HexColor("#5B5B5B"), fontSize: 15.sp)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setEmailError("Please enter an email address");
                                  //return 'Please enter an email address';
                                }
                                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value!)) {
                                  setEmailError("Please enter a valid email address");
                                  // return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: emailError.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child: Text(
                              emailError,
                              style: TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: TouchableOpacity(
                    onTap: () async {
                      if (_formKey1.currentState!.validate()) {
                        if (emailController.text.isEmpty) {
                          return;
                        }
                        if (!emailRegex.hasMatch(emailController.text)) {
                          return;
                        }
                        LoadingUtil.show(context);
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          LoadingUtil.hide(context);
                          showVerificationDialog();
                          setState(() {
                            isVerified = true;
                          });
                        });
                      }
                    },
                    child: Container(
                      width: widthScreen(),
                      height: 68.sp,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(color: HexColor("#262626"), fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.sp,
                ),
              ],
            ),
          );
  }

  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  String verifyError = "";

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
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextWidget(
          text: 'Please enter the verification code\nsent to your email',
          fontSize: 15.sp,
          color: HexColor("#CACACA"),
          fontWeight: FontWeight.w500,
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
                color: (verifyError.isNotEmpty ? HexColor("#FF6363") : Colors.white).withOpacity(0.10),
                border: Border.all(color: verifyError.isNotEmpty ? HexColor("#FF6363") : HexColor("#5A5A5A"), width: 1.sp),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30.sp,
                ),
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    hintText: "0",
                    hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.sp, color: HexColor("#878686"))),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => _onSubmit(value, index),
              ),
            );
          }),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: TouchableOpacity(
            onTap: () {
              for (int i = 0; i < _focusNodes.length; i++) {
                _focusNodes[i].unfocus();
              }
              for (var con in _controllers) {}
              String otp = _controllers.map((controller) => controller.text).join();
              onVerify(otp);
            },
            child: Container(
              width: widthScreen(),
              height: 68.sp,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Verify",
                  style: TextStyle(
                    color: HexColor("#262626"),
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: 'Did not receive code?',
              fontSize: 15.sp,
              color: Colors.white,
            ),
            TouchableOpacity(
              onTap: () {
                resendCode();
              },
              disabled: resendDuration > Duration.zero,
              child: Container(
                height: 40.sp,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                color: Colors.transparent,
                child: Center(
                  child: TextWidget(
                    text: resendDuration > Duration.zero ? '${resendDuration.inSeconds}s' : 'Resend',
                    fontSize: 15.sp,
                    color: HexColor("#0A9AAA"),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.sp,
        ),
        Text(
          verifyError,
          textAlign: TextAlign.center,
          style: TextStyle(color: HexColor("#FF4568"), fontSize: 13.sp, fontWeight: FontWeight.w400),
        )
        /* ButtonWidget(
          height: 55,
          radius: 10,
          width: 350.sp,
          label: 'Verify',
          onPressed: () {
            /*  setState(() {
              registrationIndexPage++;
            }); */
            String otp =
                _controllers.map((controller) => controller.text).join();
            onVerify(otp);
          },
        ), */
      ],
    );
  }

  String emailError = "";

  void setEmailError(String message) {
    if (emailError.isEmpty) {
      setState(() {
        emailError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          emailError = "";
        });
      });
    }
  }

  void _onSubmit(String value, int index) {
    if (value.isEmpty && index > 0) {
      _controllers[index].clear();
      _focusNodes[index - 1].requestFocus();
      // FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    } else if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.length == 1 && index == 5) {
      _focusNodes[index].unfocus();

      // Print all the values from the controllers
      String otp = _controllers.map((controller) => controller.text).join();
      log('Entered OTP: $otp');
      onVerify(otp);

      // Perform OTP verification here
    }
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.isEmpty) {
      _focusNodes[0].requestFocus();
    }
  }

  void onVerify(String otp) {
    if (otp == "123456" || otp == "000000" || otp == "111111") {
      setState(() {
        registrationAccomplishedPage = 0;
        registrationIndexPage = 1;
      });

      if (codeTimer != null) {
        codeTimer!.cancel();
      }

      setState(() {
        isVerified = false;
      });
    } else {
      //error here
      setVerifyError("You have entered the wrong verification code.\nPlease try again.");
    }
  }

  void setVerifyError(String message) {
    if (verifyError.isEmpty) {
      setState(() {
        verifyError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          verifyError = "";
        });
      });
    }
  }

  showVerificationDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white.withOpacity(0.85),
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
                    isBold: true,
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

    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].clear();
    }

    _focusNodes[0].requestFocus();

    resetCodeTimer();
  }

  Duration resendDuration = const Duration(seconds: 60);

  Timer? codeTimer;

  void resetCodeTimer() {
    if (codeTimer != null) {
      codeTimer!.cancel();
    }

    setState(() {
      resendDuration = const Duration(seconds: 60);
    });

    codeTimer = Timer.periodic(const Duration(milliseconds: 1000), (tick) {
      setState(() {
        resendDuration = resendDuration - const Duration(milliseconds: 1000);
      });
    });
  }

  void resendCode() {
    LoadingUtil.show(context);
    Future.delayed(const Duration(milliseconds: 1500), () {
      LoadingUtil.hide(context);

      resetCodeTimer();
      for (int i = 0; i < _controllers.length; i++) {
        _controllers[i].clear();
      }

      _focusNodes[0].requestFocus();
    });
  }
}
