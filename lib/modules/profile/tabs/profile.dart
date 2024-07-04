import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/widgets/TextWidget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60.sp,
            height: 30.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Center(
              child: TextWidget(
                text: 'Bio',
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          TextWidget(
            text: 'Pretty Girl',
            fontSize: 22.sp,
            color: Colors.white,
          ),
          SizedBox(
            height: 15.sp,
          ),
          Container(
            width: 135.sp,
            height: 30.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Center(
              child: TextWidget(
                text: 'Basic Information',
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          TextWidget(
            text: 'Scorpio',
            fontSize: 22.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
