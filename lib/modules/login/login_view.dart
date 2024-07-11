import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/constants/StorageCodes.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';

import 'package:glive/models/database/AdminModel.dart';

import 'package:glive/models/response/LoginResponse.dart';
import 'package:glive/modules/home/home_view.dart';
import 'package:glive/network/ApiEndpoints.dart';
import 'package:glive/network/NetworkProvider.dart';
import 'package:glive/repositories/AdminRepository.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/LoadingUtil.dart';
import 'package:glive/utils/LocalStorage.dart';
import 'package:glive/utils/MeasureSize.dart';
import 'package:glive/utils/syncHelper.dart';
import 'package:glive/utils/ToastHelper.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:glive/widgets/TouchableOpacity.dart';
import 'package:glive/widgets/AppPasswordInput.dart';
import 'package:glive/widgets/AppTextInput.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/parameters/LoginParameter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  NetworkProvider networkProvider = NetworkProvider();
  bool _obscureText = true;

  String emailError = "";
  String passwordError = "";

  void setEmailError(String message) {
    if (emailError.isEmpty) {
      setState(() {
        emailError = message;
      });
      Future.delayed(Duration(milliseconds: 3000), () {
        setState(() {
          emailError = "";
        });
      });
    }
  }

  void setPasswordError(String message) {
    if (passwordError.isEmpty) {
      setState(() {
        passwordError = message;
      });
      Future.delayed(Duration(milliseconds: 3000), () {
        setState(() {
          passwordError = "";
        });
      });
    }
  }

  final box = GetStorage();

  void socialLogin(String email, String password) {
    LoadingUtil.show(context);

    Future.delayed(Duration(milliseconds: 1500), () {
      if (email == 'kurtsanmiguel@gmail.com' && password == '@kurt123') {
        Get.offNamed(RouteNames.home);
        // ToastHelper.success('Successfully Log in');
      } else {
        if (email != 'kurtsanmiguel@gmail.com') {
          ToastHelper.error('Incorrect email, try again');
        } else if (password != '@kurt123') {
          ToastHelper.error('Incorrect password, try again');
        } else {
          ToastHelper.error('Incorrect credentials, try again');
        }
      }
      LoadingUtil.hide(context);
    });
  }

  void login() async {
    String username = emailController.text;
    String password = passwordController.text;
    if (username.isEmpty) {
      ToastHelper.error("Username is required");
      return;
    }
    if (password.isEmpty) {
      ToastHelper.error("Password is required");
      return;
    }
    LoadingUtil.show(context);

    String response = await networkProvider.post(ApiEndpoints.login,
        body: LoginParameter(email: username, password: password));

    if (jsonDecode(response)['c'] == 200) {
      try {
        // LoginResponse loginResponse =
        //     LoginResponse.fromJson(jsonDecode(response));

        // await LocalStorage.save(
        //     StorageCodes.token, loginResponse.token.toString());
        // await LocalStorage.save(StorageCodes.isLoggedIn, "true");
        // GlobalVariables.currentUser = loginResponse.user!;
        // GlobalVariables.isUserReady = true;
        // await LocalStorage.save(
        //     StorageCodes.currentUser, jsonEncode(loginResponse.user!.toJson()));
        // await AdminRepository.save(GlobalVariables.currentUser);
        // await SyncHelper.checkSync();

        box.write('started', 'true');

        Get.offNamed(RouteNames.home);
      } catch (e) {
        showToast(e.toString());
      }

      return;
    } else {
      showToast('Invalid email or password');
    }

    LoadingUtil.hide(context);
  }

  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  void showFacebookLogin(BuildContext context) {
    LoadingUtil.show(context);
    Future.delayed(Duration(milliseconds: 1500), () {
      LoadingUtil.hide(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return OAuthDialog(
            platform: 'Facebook',
            logoAsset: 'assets/images/facebook.png',
            primaryColor: Color(0xFF1877F2),
            onLogin: (email, password) {
              socialLogin(email, password);
            },
          );
        },
      );
    });
  }

  void showGoogleLogin(BuildContext context) {
    LoadingUtil.show(context);
    Future.delayed(Duration(milliseconds: 1500), () {
      LoadingUtil.hide(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return OAuthDialog(
            platform: 'Google',
            logoAsset: 'assets/images/google.png',
            primaryColor: Color(0xFFDB4437),
            onLogin: (email, password) {
              socialLogin(email, password);
            },
          );
        },
      );
    });
  }

  void showAppleLogin(BuildContext context) {
    LoadingUtil.show(context);
    Future.delayed(Duration(milliseconds: 1500), () {
      LoadingUtil.hide(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return OAuthDialog(
            platform: 'Apple',
            logoAsset: 'assets/images/apple.png',
            primaryColor: Colors.black,
            onLogin: (email, password) {
              socialLogin(email, password);
            },
          );
        },
      );
    });
  }

  double contentHeight = heightScreen();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widthScreen(),
        height: heightScreen(),
        decoration: BoxDecoration(
          color: Colors.black,
          gradient: LinearGradient(
            colors: AppColors.gradients,
            stops: const [0.0, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: contentHeight < heightScreen()
                    ? (heightScreen() - contentHeight) / 2
                    : 0),
            child: MeasureSize(
              onChange: (size) {
                setState(() {
                  contentHeight = size.height;
                });
              },
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 165.sp,
                          'assets/images/logo.png',
                        ),
                        TextWidget(
                          text: 'Log in to Unlock Best Experience!',
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 60.sp,
                        ),

                        /* AppTextInput(
                          width: 350.sp,
                          title: 'Email Address',
                          controller: emailController,
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ), */
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 15.sp),
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
                                      color: passwordError.isNotEmpty
                                          ? Colors.red
                                          : HexColor("#5A5A5A")),
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: Colors.white.withOpacity(0.10),
                                ),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 15.sp),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Password",
                                              style: TextStyle(
                                                color: HexColor("#989898"),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Container(
                                              height: 30.sp,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          passwordController,
                                                      obscureText: _obscureText,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.sp),
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "*****************",
                                                        hintStyle: TextStyle(
                                                          color: HexColor(
                                                              "#5B5B5B"),
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
                                      visible:
                                          passwordController.text.isNotEmpty,
                                      child: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: HexColor("#ACACAC"),
                                          size: 24.sp,
                                        ),
                                        onPressed: () {
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
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12.sp),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        /* AppPasswordInput(
                            width: 350.sp,
                            title: "Password",
                            controller: passwordController,
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
                              if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                  .hasMatch(value)) {
                                return 'Password must contain at least one special character';
                              }
                              
                              return null;
                            },
                            icon: Icons.lock), */
                        Padding(
                          padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /*   SizedBox(
                                width: 200,
                                child: SwitchListTile(
                                  activeColor: AppColors.bluegreen,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: TextWidget(
                                    text: 'Remember Me',
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value;
                                    });
                                  },
                                ),
                              ), */
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: 47.sp,
                                      height: 24.sp,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.sp),
                                        color: !isChecked
                                            ? Color(0xFF00A2AC)
                                            : Colors.grey,
                                      ),
                                      child: Stack(
                                        children: [
                                          AnimatedPositioned(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn,
                                            left: !isChecked ? 23.sp : 0.sp,
                                            right: !isChecked ? 0.sp : 23.sp,
                                            child: Container(
                                              width: 24.sp,
                                              height: 24.sp,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                              ),
                                              child: Center(
                                                child: Container(
                                                  height: 16.sp,
                                                  width: 16.sp,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7.sp,
                                  ),
                                  TouchableOpacity(
                                    onTap: () {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    },
                                    child: TextWidget(
                                      text: 'Remember Me',
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(RouteNames.forgotpassword);
                                },
                                child: TextWidget(
                                  text: 'Forgot Password?',
                                  fontSize: 15.sp,
                                  color: HexColor("#0A9AAA"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: TouchableOpacity(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  if (!emailRegex
                                      .hasMatch(emailController.text)) {
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
                                  if (!RegExp(r'\d')
                                      .hasMatch(passwordController.text)) {
                                    return;
                                  }
                                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                      .hasMatch(passwordController.text)) {
                                    return;
                                  }

                                  LoadingUtil.show(context);

                                  Future.delayed(Duration(milliseconds: 1500),
                                      () {
                                    LoadingUtil.hide(context);

                                    if (emailController.text ==
                                            'kurtsanmiguel@gmail.com' &&
                                        passwordController.text == '@kurt123') {
                                      Get.offNamed(RouteNames.home);
                                      /*  ToastHelper.success(
                                          'Successfully Log in'); */
                                    } else {
                                      if (emailController.text !=
                                          'kurtsanmiguel@gmail.com') {
                                        ToastHelper.error(
                                            'Incorrect email, try again');
                                      } else if (passwordController.text !=
                                          '@kurt123') {
                                        ToastHelper.error(
                                            'Incorrect password, try again');
                                      } else {
                                        ToastHelper.error(
                                            'Incorrect credentials, try again');
                                      }
                                    }
                                  });
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
                                  "Log in",
                                  style: TextStyle(
                                      color: HexColor("#262626"),
                                      fontSize: 20.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*  ButtonWidget(
                          radius: 10,
                          label: 'Log in',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (emailController.text ==
                                      'kurtsanmiguel@gmail.com' &&
                                  passwordController.text == '@kurt123') {
                                Get.offNamed(RouteNames.home);
                                ToastHelper.success('Successfully Log in');
                              } else {
                                if (emailController.text !=
                                    'kurtsanmiguel@gmail.com') {
                                  ToastHelper.error('Incorrect email, try again');
                                } else if (passwordController.text != '@kurt123') {
                                  ToastHelper.error(
                                      'Incorrect password, try again');
                                } else {
                                  ToastHelper.error(
                                      'Incorrect credentials, try again');
                                }
                              }
                            }
                          },
                        ), */
                        SizedBox(
                          height: 15.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: 'Don’t have an account?',
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteNames.signup);
                              },
                              child: TextWidget(
                                text: 'Create Account',
                                fontSize: 15.sp,
                                color: HexColor("#0A9AAA"),
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
                          height: 10.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 3; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: TouchableOpacity(
                                  onTap: () {
                                    //Get.offNamed(RouteNames.security);
                                    if (i == 0) {
                                      showFacebookLogin(context);
                                    } else if (i == 1) {
                                      showGoogleLogin(context);
                                    } else if (i == 2) {
                                      showAppleLogin(context);
                                    }
                                  },
                                  child: Container(
                                    width: 55.sp,
                                    height: 55.sp,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/${socialMediaImages[i]}.png',
                                        height: 24.sp,
                                        width: 24.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OAuthDialog extends StatefulWidget {
  final String platform;
  final String logoAsset;
  final Color primaryColor;
  final Function onLogin;

  OAuthDialog({
    required this.platform,
    required this.logoAsset,
    required this.primaryColor,
    required this.onLogin,
  });

  @override
  State<OAuthDialog> createState() => _OAuthDialogState();
}

class _OAuthDialogState extends State<OAuthDialog> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(0),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.logoAsset,
              height: 50,
              color: widget.logoAsset.contains("apple")
                  ? widget.primaryColor
                  : null,
            ),
            SizedBox(height: 20),
            Text(
              'Log in with ${widget.platform}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailCon,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordCon,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
                Navigator.pop(context);
                widget.onLogin(emailCon.text, passwordCon.text);
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
