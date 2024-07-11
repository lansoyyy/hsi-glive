import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/forgot_password/tabs/email_tab.dart';
import 'package:glive/modules/forgot_password/tabs/password_tab.dart';
import 'package:glive/modules/security/channels_view.dart';
import 'package:glive/modules/security/fingerprint_view.dart';
import 'package:glive/modules/signup/tabs/email_tab.dart';
import 'package:glive/modules/signup/tabs/password_tab.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/widgets/TextWidget.dart';

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

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30.sp,
                        width: 30.sp,
                        decoration: const BoxDecoration(
                            color: Colors.white38, shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    TextWidget(
                      text: features[forgotpasswordIndexPage],
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                SizedBox(
                  width: 200,
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: FlutterStepIndicator(
                      height: 28,
                      paddingLine: const EdgeInsets.symmetric(horizontal: 0),
                      positiveColor: const Color(0xFFC30FCC),
                      progressColor: Colors.white,
                      negativeColor: const Color(0xFFD5D5D5),
                      padding: const EdgeInsets.all(4),
                      list: list,
                      division: counter,
                      onChange: (i) {},
                      page: forgotpasswordIndexPage,
                      onClickItem: (p0) {
                        setState(() {
                          forgotpasswordIndexPage = p0;
                        });
                      },
                    ),
                  ),
                ),
                IndexedStack(
                  index: forgotpasswordIndexPage,
                  children: const [
                    ForgotPasswordEmailTab(),
                    ForgotPasswordTab(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
