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
                    Get.offNamed(RouteNames.login);
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                Get.offNamed(RouteNames.login);
              },
            ),
            SizedBox(
              height: 50.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Don’t have an account?',
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
