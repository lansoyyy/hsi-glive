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

class InterestTab extends StatefulWidget {
  const InterestTab({super.key});

  @override
  State<InterestTab> createState() => _InterestTabState();
}

class _InterestTabState extends State<InterestTab> {
  TextEditingController refCode = TextEditingController();

  List interests = [
    'Animals',
    'Comedy',
    'Travel',
    'Food',
    'Sports',
    'Beauty & Style',
    'Art',
    'Gaming',
  ];

  Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.sp,
        ),
        TextWidget(
          align: TextAlign.start,
          text: 'Choose your\ninterest',
          fontSize: 30.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextWidget(
          text: 'Get better video recommendations',
          fontSize: 12.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 50.sp,
        ),
        Wrap(
          children: [
            for (int i = 0; i < interests.length; i++)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedInterests.contains(interests[i])) {
                        selectedInterests.remove(interests[i]);
                      } else {
                        if (selectedInterests.length <= 2) {
                          selectedInterests.add(interests[i]);
                        }
                      }
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 40.sp,
                    decoration: !selectedInterests.contains(interests[i])
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pink,
                          ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/images/interest/${interests[i]}.png'),
                          SizedBox(
                            width: 10.sp,
                          ),
                          TextWidget(
                            text: interests[i],
                            fontSize: 14.sp,
                            color: selectedInterests.contains(interests[i])
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 180.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonWidget(
              radius: 10,
              width: 175.sp,
              textColor: Colors.white,
              color: Colors.grey,
              label: 'Skip',
              onPressed: () {
                // // Collect OTP from the controllers and perform verification
                // String otp =
                //     _controllers.map((controller) => controller.text).join();
                // print("Entered OTP: $otp");

                setState(() {
                  registrationIndexPage++;
                });
              },
            ),
            ButtonWidget(
              width: 175.sp,
              radius: 10,
              textColor: Colors.white,
              color: const Color(0XFF0A9AAA),
              label: 'Continue',
              onPressed: () async {
                // authchack(context);

                setState(() {
                  registrationIndexPage++;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 50.sp,
        ),
      ],
    );
  }
}
