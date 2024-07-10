import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/utils/GlobalVariables.dart';

class ToastHelper {
  static void error(String message) {
    showToastWidget(
      Container(
        width: 250.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red.withOpacity(0.25),
          border: Border.all(
            color: Colors.red,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 18.sp,
              ),
              SizedBox(
                width: 10.sp,
              ),
              TextWidget(
                text: message,
                fontSize: 14,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void success(String message) {
    showToastWidget(
      Container(
        width: 250.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green.withOpacity(0.25),
          border: Border.all(
            color: Colors.green,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 18.sp,
              ),
              SizedBox(
                width: 10.sp,
              ),
              TextWidget(
                text: message,
                fontSize: 14,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
