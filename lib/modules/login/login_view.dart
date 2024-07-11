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

  final box = GetStorage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          gradient: LinearGradient(
            colors: AppColors.gradiants,
            stops: const [0.0, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Form(
              key: _formKey,
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
                    height: 75.sp,
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
                  AppPasswordInput(
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
                      icon: Icons.lock),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: SwitchListTile(
                            activeColor: AppColors.bluegreen,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: TextWidget(
                              text: 'Remember-Me',
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
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(RouteNames.forgotpassword);
                          },
                          child: TextWidget(
                            text: 'Forgot Password',
                            fontSize: 12.sp,
                            color: const Color(0XFF85ECF8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  ButtonWidget(
                    radius: 10,
                    label: 'Log in',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (emailController.text == 'kurtsanmiguel@gmail.com' &&
                            passwordController.text == '@kurt123') {
                          Get.offNamed(RouteNames.home);
                          ToastHelper.success('Successfully Log in');
                        } else {
                          if (emailController.text !=
                              'kurtsanmiguel@gmail.com') {
                            ToastHelper.error('Incorrect email, try again');
                          } else if (passwordController.text != '@kurt123') {
                            ToastHelper.error('Incorrect password, try again');
                          } else {
                            ToastHelper.error(
                                'Incorrect credentials, try again');
                          }
                        }
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
                        text: 'Don’t have an account?',
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RouteNames.signup);
                        },
                        child: TextWidget(
                          text: 'Create Account',
                          fontSize: 14.sp,
                          color: AppColors.bluegreen,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.sp,
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
            ),
          ),
        ),
      ),
    );
  }
}
