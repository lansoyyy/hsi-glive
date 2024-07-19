import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bottomSheetDivider() {
  return Center(
    child: FractionallySizedBox(
      widthFactor: 0.15,
      child: Container(
        margin: EdgeInsets.only(bottom: 6.sp),
        child: Container(
          height: 5.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    ),
  );
}
