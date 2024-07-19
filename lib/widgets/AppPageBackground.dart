// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:glive/constants/AppColors.dart';

class AppPageBackground extends StatelessWidget {
  final Widget child;
  const AppPageBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: AppColors.bgGradientColors,
        ),
      ),
      width: size.width,
      height: size.height,
      child: child,
    );
  }
}
