import 'package:flutter/material.dart';
import 'package:glive/constants/assets.dart';
import 'package:glive/utils/commonFunctions.dart';
import 'package:glive/utils/globalVariables.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: heightScreen(),
        width: widthScreen(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleShadow(
              child: Image.asset(
                Assets.icon,
                height: 100,
                width: 100,
              ),
              opacity: 0.25, // Default: 0.5
              color: Colors.grey, // Default: Black
              offset: const Offset(1, 1), // Default: Offset(2, 2)
              sigma: 7, // Default: 2
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "QR Project",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
