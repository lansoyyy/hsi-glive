// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/network/ApiEndpoints.dart';
import 'package:glive/network/NetworkProvider.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/utils/LoadingUtil.dart';
import 'package:glive/utils/ToastHelper.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';
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

    String response = await networkProvider.post(ApiEndpoints.login, body: LoginParameter(email: username, password: password));

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

        Get.offNamed(AppRoutes.HOME);
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

  List socialMediaImages = ['facebook', 'instagram', 'google', 'tiktok'];

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
              height: 75.sp,
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
            AppPasswordInput(width: 350.sp, title: "Password", controller: passwordController, icon: Icons.lock),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        TextWidget(
                          text: 'Remember-Me',
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
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
              label: 'Sign In',
              onPressed: () {
                Get.offNamed(AppRoutes.HOME);
              },
            ),
            SizedBox(
              height: 50.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100.sp,
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                TextWidget(
                  text: 'or continue with',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.sp,
                ),
                SizedBox(
                  width: 100.sp,
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: GestureDetector(
                      onTap: () {
                        Get.offNamed(AppRoutes.SECURITY);
                      },
                      child: Container(
                        width: 55.sp,
                        height: 55.sp,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.5),
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
    );
  }
}
