// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:glive/constants/appColors.dart';

class ToastHelper {
  static void error(String message) {
    showToastWidget(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000), color: AppColors.red),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    ));
  }

  static void success(String message) {
    showToastWidget(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000), color: AppColors.green),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    ));
  }
}
