// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/widgets/ButtonWidget.dart';

class LiveDialogs {
  static Future<bool> showDiscardLiveDialog(BuildContext context) async {
    return await Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              height: 270.sp,
              width: 320.sp,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 45.sp),
                    child: Center(
                        child: Text('Discard the live?',
                            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF262626)))),
                  ),
                  ButtonWidget(
                    label: 'Yes',
                    radius: 10.sp,
                    height: 50.sp,
                    width: 155.sp,
                    fontSize: 16.sp,
                    color: const Color(0xFF0A9AAA),
                    textColor: const Color(0xFFD3D3D3),
                    onPressed: () {
                      return Get.back(result: true);
                    },
                  ).paddingOnly(bottom: 10.h),
                  ButtonWidget(
                    label: 'No',
                    radius: 10.sp,
                    height: 50.sp,
                    width: 155.sp,
                    fontSize: 16.sp,
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      return Get.back(result: false);
                    },
                  ).paddingOnly(bottom: 16.h),
                ],
              ),
            ),
          ),
        ));
  }
}
