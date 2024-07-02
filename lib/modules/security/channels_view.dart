import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/routes.dart';
import 'package:glive/widgets/TextWidget.dart';

import '../../widgets/ButtonWidget.dart';

class ChannelsView extends StatelessWidget {
  const ChannelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.mic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 20.sp,
        ),
        TextWidget(
          text: 'Select a Channel to Follow',
          fontSize: 25.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 10.sp,
        ),
        TextWidget(
          text: '''
Follow some of the live seller
channel that you may know below.
''',
          fontSize: 15.sp,
          color: Colors.white,
        ),

        Padding(
          padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/avatar.png',
                width: 75.sp,
                height: 114.sp,
              ),
              SizedBox(
                width: 10.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Madam Inuts',
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                  TextWidget(
                    text: '159k Followers',
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 10.sp,
                ),
              ),
              Image.asset(
                'assets/images/follow.png',
                width: 120.sp,
                height: 40.sp,
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 450.sp,
        //   child: ListView.builder(
        //     itemBuilder: (context, index) {
        //       return
        //     },
        //   ),
        // ),
        SizedBox(
          height: 150.sp,
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

                Get.toNamed(RouteNames.home);
              },
            ),
            ButtonWidget(
              radius: 10,
              width: 175.sp,
              textColor: Colors.white,
              color: const Color(0XFF0A9AAA),
              label: 'Confirm',
              onPressed: () {
                // // Collect OTP from the controllers and perform verification
                // String otp =
                //     _controllers.map((controller) => controller.text).join();
                // print("Entered OTP: $otp");

                Get.toNamed(RouteNames.home);
              },
            ),
          ],
        ),
        SizedBox(
          height: 20.sp,
        ),
      ],
    );
  }
}
