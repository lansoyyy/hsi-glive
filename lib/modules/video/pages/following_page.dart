import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FollowingPage extends StatelessWidget {
  final String pageName;
  final int index;
  const FollowingPage({super.key, required this.pageName, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Connect with friends to view their posts",
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold)),
            ).paddingOnly(bottom: 16.h),
            Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Center(
                  child: Text(
                "Connect with contacts",
                style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w400),
              )),
            ).paddingOnly(bottom: 12.h),
            Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade700,
              ),
              child: Center(
                  child: Text(
                "Connect with Facebook friends",
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
              )),
            ).paddingOnly(bottom: 12.h),
            Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade700,
              ),
              child: Center(
                  child: Text(
                "Invite friends",
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
              )),
            )
          ],
        ).paddingOnly(left: 24.w, right: 24.w, top: 100.h),
      ),
    );
  }
}
