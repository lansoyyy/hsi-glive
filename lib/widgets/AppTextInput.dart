import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    super.key,
    required this.width,
    required this.title,
    required this.controller,
    required this.icon,
    this.validator, // Add validator parameter
  });

  final double width;
  final String title;
  final IconData icon;
  final TextEditingController controller;

  final String? Function(String?)? validator; // Add validator parameter

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  FocusNode focusNode = FocusNode();

  String text = "";
  bool isFocused = false;

  @override
  void initState() {
    focusNode.addListener(nodeListener);
    widget.controller.addListener(textListener);

    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(nodeListener);
    widget.controller.removeListener(textListener);
    super.dispose();
  }

  void nodeListener() {
    if (!mounted) {
      return;
    }
    if (focusNode.hasFocus) {
      setState(() {
        isFocused = true;
      });
    } else {
      setState(() {
        isFocused = false;
      });
    }
  }

  void textListener() {
    if (!mounted) {
      return;
    }
    setState(() {
      text = widget.controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasValue = false;

    if (isFocused) {
      hasValue = true;
    }

    if (text.isNotEmpty) {
      hasValue = true;
    }

    double myWidth = widget.width;
    if (myWidth < 0) {
      myWidth = 0;
    }

    return Container(
      height: 75.sp,
      width: myWidth,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.30),
          boxShadow: [
            BoxShadow(
              color: isFocused
                  ? Colors.grey.withOpacity(0.30)
                  : Colors.transparent,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.white, width: 0.30),
          borderRadius: BorderRadius.circular(5)),
      child: Stack(
        children: [
          Container(
            height: 60,
            width: myWidth,
            padding: const EdgeInsets.only(left: 60, right: 10),
            child: Center(
              child: TextFormField(
                validator: widget.validator,
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: widget.controller,
                focusNode: focusNode,
                cursorColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: widget.title,
                    labelStyle: TextStyle(
                        color:
                            hasValue ? AppColors.primaryColor : AppColors.grey),
                    isDense: true,
                    hintStyle: TextStyle(color: AppColors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            bottom: hasValue ? -10 : 0,
            left: 10,
            child: SizedBox(
              height: 60,
              width: 40,
              child: Center(
                child: Icon(
                  widget.icon,
                  color: hasValue ? AppColors.primaryColor : AppColors.grey,
                  size: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
