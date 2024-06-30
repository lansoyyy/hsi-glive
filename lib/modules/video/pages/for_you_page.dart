import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForYouPage extends StatelessWidget {
  final String pageName;
  final int index;
  const ForYouPage({super.key, required this.pageName, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 45.h,
            left: 0,
            right: 1.w,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.search, color: Colors.white, size: 30.r).paddingOnly(right: 8.w),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Trending creators",
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500)),
                ).paddingOnly(bottom: 4.h),
                Center(
                  child: Text("Follow an account to see their latest \nvideos here.",
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400)),
                ).paddingOnly(bottom: 24.h),
                Container(
                  height: 320.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80",
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundImage: const NetworkImage(
                            "https://images.unsplash.com/photo-1523824921871-d6f1a15151f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                        radius: 38.r,
                      ).paddingOnly(bottom: 12.h),
                      Center(
                        child: Text("Tony Pogi",
                            textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      ).paddingOnly(bottom: 4.h),
                      Center(
                        child: Text("@tonypogi",
                            textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w300)),
                      ).paddingOnly(bottom: 8.h),
                      Container(
                        height: 45.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.pink,
                        ),
                        child: Center(
                            child: Text(
                          "Follow",
                          style: TextStyle(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w400),
                        )),
                      ).paddingOnly(bottom: 16.h),
                    ],
                  ),
                ).paddingOnly(bottom: 12.h),
              ],
            ).paddingOnly(left: 70.w, right: 70.w, top: 50.h),
          ),
        ],
      ),
    );
  }
}
