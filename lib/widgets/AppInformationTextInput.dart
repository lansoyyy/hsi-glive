import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';

class AppInformationTextInput extends StatefulWidget {
  const AppInformationTextInput(
      {super.key,
      required this.width,
      required this.title,
      required this.controller,
      required this.icon});

  final double width;
  final String title;
  final IconData icon;
  final TextEditingController controller;

  @override
  State<AppInformationTextInput> createState() =>
      _AppInformationTextInputState();
}

class _AppInformationTextInputState extends State<AppInformationTextInput> {
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
      height: 65.sp,
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: TextField(
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
                    hintText: 'Enter ${widget.title}',
                    labelStyle: TextStyle(
                        color:
                            hasValue ? AppColors.primaryColor : AppColors.grey),
                    isDense: true,
                    hintStyle: TextStyle(color: AppColors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
