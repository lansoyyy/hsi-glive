import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/routes.dart';
import 'package:glive/widgets/ButtonWidget.dart';

import '../../widgets/TextWidget.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onSubmit(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.length == 1 && index == 5) {
      _focusNodes[index].unfocus();
      // Perform OTP verification here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100.sp,
          ),
          TextWidget(
            text: 'Create New PIN',
            fontSize: 25.sp,
            color: Colors.black,
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextWidget(
            text: 'Add PIN  number to make your\naccount more secure',
            fontSize: 15.sp,
            color: Colors.black,
          ),
          SizedBox(
            height: 20.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return Container(
                width: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.30),
                  border: Border.all(color: Colors.white, width: 0.30),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: (value) => _onSubmit(value, index),
                ),
              );
            }),
          ),
          SizedBox(
            height: 50.sp,
          ),
          ButtonWidget(
            textColor: Colors.white,
            color: const Color(0XFF0A9AAA),
            label: 'Confirm',
            onPressed: () {
              // // Collect OTP from the controllers and perform verification
              // String otp =
              //     _controllers.map((controller) => controller.text).join();
              // print("Entered OTP: $otp");

              Get.toNamed(RouteNames.fingerprint);
            },
          ),
        ],
      ),
    );
  }
}
