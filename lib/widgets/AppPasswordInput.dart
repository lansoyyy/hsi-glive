// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

class AppPasswordInput extends StatefulWidget {
  const AppPasswordInput({super.key, required this.width, required this.title, required this.controller, required this.icon});

  final double width;
  final String title;
  final IconData icon;
  final TextEditingController controller;

  @override
  State<AppPasswordInput> createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  FocusNode focusNode = FocusNode();

  String text = "";
  bool isFocused = false;

  bool isOpened = false;
  bool isEyePressed = false;

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

  void textListener() {
    if (!mounted) {
      return;
    }
    setState(() {
      text = widget.controller.text;
    });
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
      if (kIsWeb) {
        timeoutFix();
      } else {
        if (Platform.isWindows || Platform.isLinux) {
          timeoutFix();
        } else {
          setState(() {
            isFocused = false;
            isOpened = false;
          });
        }
      }
    }
  }

  void timeoutFix() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (isEyePressed) {
        setState(() {
          isEyePressed = false;
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
          isOpened = false;
        });
      }
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

    return GestureDetector(
      onTapDown: (details) {},
      child: Container(
        height: 70.sp,
        width: myWidth,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.30),
            boxShadow: [
              BoxShadow(
                color: isFocused ? Colors.grey.withOpacity(0.30) : Colors.transparent,
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
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Center(
                child: TextField(
                  controller: widget.controller,
                  obscureText: isFocused ? !isOpened : true,
                  focusNode: focusNode,
                  cursorColor: AppColors.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      text = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: widget.title,
                      labelStyle: TextStyle(color: hasValue ? AppColors.primaryColor : AppColors.grey),
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
            ),
            Visibility(
              visible: isFocused,
              child: AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                right: 10,
                child: TouchableOpacity(
                  onTap: () {
                    setState(() {
                      isOpened = !isOpened;
                      isEyePressed = true;
                    });
                    focusNode.requestFocus();
                  },
                  child: Container(
                    height: 60,
                    width: 40,
                    color: Colors.transparent,
                    child: Center(
                      child: Image.asset(
                        !isOpened ? Assets.eye_opened : Assets.eye_closed,
                        color: AppColors.secondaryColor,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
