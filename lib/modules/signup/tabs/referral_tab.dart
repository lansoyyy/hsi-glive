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

import '../../../widgets/AppPasswordInput.dart';

class ReferralTab extends StatefulWidget {
  const ReferralTab({super.key});

  @override
  State<ReferralTab> createState() => _ReferralTabState();
}

class _ReferralTabState extends State<ReferralTab> {
  TextEditingController refCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.sp,
        ),
        TextWidget(
          text: 'Referral Code',
          fontSize: 30.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextWidget(
          text: 'Enter your referral code.',
          fontSize: 12.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 50.sp,
        ),
        Center(
          child: AppPasswordInput(
              width: 350.sp,
              title: 'Referral Code',
              controller: refCode,
              icon: Icons.account_box_outlined),
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
              registrationIndexPage++;
            });
          },
        ),
        SizedBox(
          height: 10.sp,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              registrationIndexPage++;
            });
          },
          child: TextWidget(
            text: 'Skip (For Now)',
            fontSize: 16.sp,
            color: AppColors.bluegreen,
          ),
        ),
        SizedBox(
          height: 50.sp,
        ),
      ],
    );
  }
}
