// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glive/constants/appColors.dart';

class AppNumberInput extends StatefulWidget {
  const AppNumberInput({super.key, required this.width, required this.title, required this.controller, required this.icon, this.onChange});

  final double width;
  final String title;
  final String icon;
  final TextEditingController controller;
  final Function(String)? onChange;

  @override
  State<AppNumberInput> createState() => _AppNumberInputState();
}

class _AppNumberInputState extends State<AppNumberInput> {
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
      setState(() {
        isFocused = false;
      });
    }
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
      height: 60,
      width: myWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: isFocused ? Colors.grey.withOpacity(0.5) : Colors.transparent,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Container(
            height: 60,
            width: myWidth,
            padding: const EdgeInsets.only(left: 60, right: 10),
            child: Center(
              child: TextField(
                controller: widget.controller,
                focusNode: focusNode,
                cursorColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                  if (widget.onChange != null) {
                    widget.onChange!(value);
                  }
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
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
                child: Image.asset(
                  widget.icon,
                  color: hasValue ? AppColors.primaryColor : AppColors.grey,
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
