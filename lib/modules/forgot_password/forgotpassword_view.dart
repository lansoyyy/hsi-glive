import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/forgot_password/tabs/email_tab.dart';
import 'package:glive/modules/forgot_password/tabs/password_tab.dart';
import 'package:glive/modules/security/channels_view.dart';
import 'package:glive/modules/security/fingerprint_view.dart';
import 'package:glive/modules/signup/tabs/email_tab.dart';
import 'package:glive/modules/signup/tabs/password_tab.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/LoadingUtil.dart';
import 'package:glive/utils/MeasureSize.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

import '../../routes.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  int counter = 2;
  List list = [
    0,
    1,
  ];

  List features = [
    'Verify Account',
    'Create New Password',
  ];

  double headerHeight = 135.5;
  @override
  Widget build(BuildContext context) {
    double lineMultiplier = 0;

    if (registrationAccomplishedPage >= 0 && registrationAccomplishedPage < 1) {
      lineMultiplier = 1;
    }

    if (registrationAccomplishedPage >= 1 && registrationAccomplishedPage < 2) {
      lineMultiplier = 2;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradients,
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              MeasureSize(
                onChange: (size) {
                  setState(() {
                    headerHeight = size.height;
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10.sp, right: 10.sp, top: 20.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 44.sp,
                                width: 44.sp,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: HexColor("#5A5A5A"))),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            TextWidget(
                              text: features[registrationIndexPage],
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 44.sp,
                              width: 44.sp,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 87.5, right: 87.5),
                        child: SizedBox(
                          width: 278.sp,
                          height: 62.sp,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 25.sp,
                                    width: 278.sp,
                                  ),
                                  Positioned(
                                    left: 5.sp,
                                    child: SizedBox(
                                      height: 25.sp,
                                      width: 278.sp,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 1,
                                            width: 175.sp,
                                            color: registrationIndexPage == 0
                                                ? HexColor("#B9B9B9")
                                                : HexColor("#3F86FE"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 5.sp,
                                    child: SizedBox(
                                      height: 25.sp,
                                      width: 278.sp,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 1,
                                            width: ((((278.sp / 2) +
                                                                25.sp) *
                                                            lineMultiplier) >
                                                        0
                                                    ? (((300.sp / 2) + 25.sp) *
                                                        lineMultiplier)
                                                    : 25.sp) -
                                                0.sp,
                                            // width: lineWidth,
                                            color: HexColor("#E630EF"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: SizedBox(
                                      height: 60.sp,
                                      width: 278.sp,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              /* if (!(registrationAccomplishedPage >=
                                                  0)) {
                                                return;
                                              }
                                              setState(() {
                                                registrationIndexPage = 0;
                                              }); */
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 30.sp,
                                                  width: 30.sp,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          registrationAccomplishedPage >=
                                                                  0
                                                              ? HexColor(
                                                                  "#C30FCC")
                                                              : Colors.white,
                                                      shape: BoxShape.circle,
                                                      border:
                                                          registrationIndexPage >=
                                                                  0
                                                              ? Border.all(
                                                                  width: 2.sp,
                                                                  color: HexColor(
                                                                      "#C30FCC"))
                                                              : null),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 18.sp,
                                                  )),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                TextWidget(
                                                  text: 'Verify\nAccount',
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              if (!(registrationAccomplishedPage >=
                                                  1)) {
                                                return;
                                              }
                                              setState(() {
                                                registrationIndexPage = 1;
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 30.sp,
                                                  width: 30.sp,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          registrationAccomplishedPage >=
                                                                  1
                                                              ? HexColor(
                                                                  "#C30FCC")
                                                              : Colors.white,
                                                      shape: BoxShape.circle,
                                                      border:
                                                          registrationIndexPage >=
                                                                  1
                                                              ? Border.all(
                                                                  width: 2.sp,
                                                                  color: HexColor(
                                                                      "#C30FCC"))
                                                              : null),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 18.sp,
                                                  )),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                TextWidget(
                                                  text: 'Create New\nPassword',
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IndexedStack(
                index: forgotpasswordIndexPage,
                children: [_emailTab(), _passwordTab()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget _passwordTab() {
    int passwordStrength = 0;
    String passwordText = "";

    if (passwordController.text.length >= 8) {
      //return 'Password must be at least 8 characters long';
      passwordStrength++;
    }
    if (RegExp(r'[a-zA-Z]').hasMatch(passwordController.text)) {
      passwordStrength++;
    }
    if (RegExp(r'\d').hasMatch(passwordController.text)) {
      passwordStrength++;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(passwordController.text)) {
      passwordStrength++;
    }

    if (passwordStrength == 1) {
      passwordText = "Weak";
    }
    if (passwordStrength == 2) {
      passwordText = "Medium";
    }
    if (passwordStrength == 3) {
      passwordText = "Good";
    }
    if (passwordStrength == 4) {
      passwordText = "Strong Password";
    }

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
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Center(
                child: TextWidget(
                  text: 'Create your password',
                  fontSize: 15.sp,
                  color: HexColor("#CACACA"),
                  fontWeight: FontWeight.w500,
                ),
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
                      width: double
                          .infinity, // You can use double.infinity to occupy the full width
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.sp,
                            color: passwordError.isNotEmpty
                                ? Colors.red
                                : HexColor("#5A5A5A")),
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white.withOpacity(0.10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      color: HexColor("#989898"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.sp,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: passwordController,
                                            obscureText: _obscureText,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.sp),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: InputBorder.none,
                                              hintText: "*****************",
                                              hintStyle: TextStyle(
                                                color: HexColor("#5B5B5B"),
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                setPasswordError(
                                                    "Please enter a password");
                                                //return 'Please enter a password';
                                              }
                                              if (value!.length < 8) {
                                                setPasswordError(
                                                    "Password must be at least 8 characters long");
                                                //return 'Password must be at least 8 characters long';
                                              }
                                              if (!RegExp(r'[a-zA-Z]')
                                                  .hasMatch(value)) {
                                                setPasswordError(
                                                    "Password must contain at least one letter");
                                                //return 'Password must contain at least one letter';
                                              }
                                              if (!RegExp(r'\d')
                                                  .hasMatch(value)) {
                                                setPasswordError(
                                                    "Password must contain at least one number");
                                                //return 'Password must contain at least one number';
                                              }
                                              if (!RegExp(
                                                      r'[!@#$%^&*(),.?":{}|<>]')
                                                  .hasMatch(value)) {
                                                setPasswordError(
                                                    "Password must contain at least one special character");
                                                //return 'Password must contain at least one special character';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: passwordController.text.isNotEmpty,
                            child: SizedBox(
                              width: 30.sp,
                              height: 30,
                              child: TouchableOpacity(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/clear.png",
                                      height: 24.sp,
                                      width: 24.sp,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    passwordController.text = "";
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: passwordController.text.isNotEmpty,
                            child: TouchableOpacity(
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: HexColor("#ACACAC"),
                                size: 24.sp,
                              ),
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: passwordError.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.sp),
                          child: Text(
                            passwordError,
                            style:
                                TextStyle(color: Colors.red, fontSize: 12.sp),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 68.sp,
                      width: double
                          .infinity, // You can use double.infinity to occupy the full width
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.sp,
                            color: cPasswordError.isNotEmpty
                                ? Colors.red
                                : HexColor("#5A5A5A")),
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white.withOpacity(0.10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Confirm Password",
                                    style: TextStyle(
                                      color: HexColor("#989898"),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.sp,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                confirmPasswordController,
                                            obscureText: _obscureText2,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.sp),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: InputBorder.none,
                                              hintText: "*****************",
                                              hintStyle: TextStyle(
                                                color: HexColor("#5B5B5B"),
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                setConfirmPasswordError(
                                                    "Please enter a password");
                                                //return 'Please enter a password';
                                              }
                                              if (value!.length < 8) {
                                                setConfirmPasswordError(
                                                    "Password must be at least 8 characters long");
                                                //return 'Password must be at least 8 characters long';
                                              }
                                              if (!RegExp(r'[a-zA-Z]')
                                                  .hasMatch(value)) {
                                                setConfirmPasswordError(
                                                    "Password must contain at least one letter");
                                                //return 'Password must contain at least one letter';
                                              }
                                              if (!RegExp(r'\d')
                                                  .hasMatch(value)) {
                                                setConfirmPasswordError(
                                                    "Password must contain at least one number");
                                                //return 'Password must contain at least one number';
                                              }
                                              if (!RegExp(
                                                      r'[!@#$%^&*(),.?":{}|<>]')
                                                  .hasMatch(value)) {
                                                setConfirmPasswordError(
                                                    "Password must contain at least one special character");
                                                //return 'Password must contain at least one special character';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: confirmPasswordController.text.isNotEmpty,
                            child: SizedBox(
                              width: 30.sp,
                              height: 30,
                              child: TouchableOpacity(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/clear.png",
                                      height: 24.sp,
                                      width: 24.sp,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    confirmPasswordController.text = "";
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: passwordController.text.isNotEmpty,
                            child: TouchableOpacity(
                              child: Icon(
                                _obscureText2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: HexColor("#ACACAC"),
                                size: 24.sp,
                              ),
                              onTap: () {
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: cPasswordError.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.sp),
                          child: Text(
                            cPasswordError,
                            style:
                                TextStyle(color: Colors.red, fontSize: 12.sp),
                          ),
                        ))
                  ],
                ),
              ),
              Visibility(
                visible: passwordStrength != 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/password$passwordStrength.png",
                        width: 88.sp,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Text(
                        passwordText,
                        style: TextStyle(color: Colors.white, fontSize: 8.sp),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: TouchableOpacity(
                  onTap: () async {
                    if (_formKey2.currentState!.validate()) {
                      if (passwordController.text.isEmpty) {
                        return;
                      }
                      if (confirmPasswordController.text.isEmpty) {
                        return;
                      }

                      if (passwordController.text.length < 8) {
                        //return 'Password must be at least 8 characters long';
                        return;
                      }
                      if (!RegExp(r'[a-zA-Z]')
                          .hasMatch(passwordController.text)) {
                        return;
                      }
                      if (!RegExp(r'\d').hasMatch(passwordController.text)) {
                        return;
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                          .hasMatch(passwordController.text)) {
                        return;
                      }

                      if (confirmPasswordController.text.length < 8) {
                        //return 'Password must be at least 8 characters long';
                        return;
                      }
                      if (!RegExp(r'[a-zA-Z]')
                          .hasMatch(confirmPasswordController.text)) {
                        return;
                      }
                      if (!RegExp(r'\d')
                          .hasMatch(confirmPasswordController.text)) {
                        return;
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                          .hasMatch(confirmPasswordController.text)) {
                        return;
                      }

                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        setState(() {
                          // dialog here

                          // registrationIndexPage = 0;
                          // registrationAccomplishedPage = -1;

                          registrationIndexPage = 0;
                          registrationAccomplishedPage = -1;
                          forgotpasswordIndexPage = 0;
                        });

                        successPasswordDialog();
                      } else {
                        // ToastHelper.error('Password do not match!');
                        setPasswordError("Passwords do not match!");
                        setConfirmPasswordError("Passwords do not match!");
                      }
                    }
                  },
                  child: Container(
                    width: widthScreen(),
                    height: 68.sp,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Save Password",
                        style: TextStyle(
                            color: HexColor("#262626"), fontSize: 20.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35.sp),
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
                        passwordController.text.length >= 8
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 17.sp,
                              )
                            : Container(
                                height: 17.sp,
                                width: 17.sp,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
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
                    SizedBox(
                      height: 4.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (RegExp(r'[a-zA-Z]')
                                    .hasMatch(passwordController.text) &&
                                RegExp(r'\d')
                                    .hasMatch(passwordController.text) &&
                                RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                    .hasMatch(passwordController.text))
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 17.sp,
                              )
                            : Container(
                                height: 17.sp,
                                width: 17.sp,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
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

  void setPasswordError(String message) {
    if (passwordError.isEmpty) {
      setState(() {
        passwordError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          passwordError = "";
        });
      });
    }
  }

  String emailError = "";
  String passwordError = "";
  String cPasswordError = "";
  String verifyError = "";

  void setConfirmPasswordError(String message) {
    if (cPasswordError.isEmpty) {
      setState(() {
        cPasswordError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        if (!mounted) {
          return;
        }
        setState(() {
          cPasswordError = "";
        });
      });
    }
  }

  bool _obscureText = true;
  bool _obscureText2 = true;

  TextEditingController emailController = TextEditingController();

  bool isVerified = false;

  final _formKey1 = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  @override
  Widget _emailTab() {
    return isVerified
        ? verifiedWidget()
        : Form(
            key: _formKey1,
            child: Center(
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
                    text:
                        'Please enter your email address to get\na link to change your password.',
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
                              border: Border.all(
                                  width: 1.sp,
                                  color: emailError.isNotEmpty
                                      ? Colors.red
                                      : HexColor("#5A5A5A")),
                              borderRadius: BorderRadius.circular(10.sp),
                              color: Colors.white.withOpacity(0.10)),
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: HexColor("#989898"),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextFormField(
                                controller: emailController,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp),
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Enter your email",
                                    hintStyle: TextStyle(
                                        color: HexColor("#5B5B5B"),
                                        fontSize: 15.sp)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    setEmailError(
                                        "Please enter an email address");
                                    //return 'Please enter an email address';
                                  }
                                  final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegex.hasMatch(value!)) {
                                    setEmailError(
                                        "Please enter a valid email address");
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
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.sp),
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
                          Future.delayed(const Duration(milliseconds: 1500),
                              () {
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                color: HexColor("#262626"), fontSize: 20.sp),
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
              height: 65.sp,
              decoration: BoxDecoration(
                color: (verifyError.isNotEmpty
                        ? HexColor("#FF6363")
                        : Colors.white)
                    .withOpacity(0.10),
                border: Border.all(
                    color: verifyError.isNotEmpty
                        ? HexColor("#FF6363")
                        : HexColor("#5A5A5A"),
                    width: 1.sp),
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
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30.sp,
                        color: HexColor("#878686"))),
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
              String otp =
                  _controllers.map((controller) => controller.text).join();
              onVerify(otp);
            },
            child: Container(
              width: widthScreen(),
              height: 68.sp,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                    text: resendDuration > Duration.zero
                        ? '${resendDuration.inSeconds}s'
                        : 'Resend',
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
          style: TextStyle(
              color: HexColor("#FF4568"),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400),
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
      print('Entered OTP: $otp');
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
        registrationAccomplishedPage++;
        registrationIndexPage++;

        forgotpasswordIndexPage++;
      });

      if (codeTimer != null) {
        codeTimer!.cancel();
      }

      setState(() {
        isVerified = false;
      });
    } else {
      //error here
      setVerifyError(
          "You have entered the wrong verification code.\nPlease try again.");
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

  successPasswordDialog() async {
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
                    'assets/images/check.png',
                    height: 100,
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  TextWidget(
                    isBold: true,
                    text: 'Password Change',
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  TextWidget(
                    text: '''
You have successfully changed your
password, keep your password
updated
''',
                    fontSize: 12,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  ButtonWidget(
                    textColor: Colors.white,
                    width: 150,
                    radius: 10,
                    color: const Color(0XFF0A9AAA),
                    label: 'Continue',
                    onPressed: () {
                      Get.offNamed(RouteNames.login);
                    },
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
