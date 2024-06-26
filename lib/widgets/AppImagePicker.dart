// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/utils/CallbackModel.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/ImageUtil.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

class AppImagePickerController extends ChangeNotifier {
  List<CallbackModel> loadFunctions = [];

  void loadData(List params) {
    for (var cb in loadFunctions) {
      cb.callback(params);
    }
  }

  void onLoadData(CallbackModel cb) {
    loadFunctions = loadFunctions.where((el) => el.id != cb.id).toList()..add(cb);
  }
}

class AppImagePicker extends StatefulWidget {
  const AppImagePicker({
    super.key,
    required this.width,
    required this.title,
    required this.icon,
    required this.onChanged,
    required this.controller,
  });

  final double width;
  final String title;
  final String icon;
  final AppImagePickerController controller;
  final Function(String, String, XFile) onChanged; //image name, base64 and xfile

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  FocusNode focusNode = FocusNode();

  String text = "";
  bool isFocused = false;

  DateTime myValue = DateTime.now();

  bool hasChanged = false;
  String imageName = "";
  String base64 = "";

  @override
  void initState() {
    focusNode.addListener(nodeListener);
    widget.controller.onLoadData(CallbackModel(id: randomString(24), callback: onLoadData));
    super.initState();
  }

  void onLoadData(dynamic d) {
    if (!mounted) {
      return;
    }
    List params = d as List;
    String myImageName = params[0];
    String myBase64 = params[1];

    setState(() {
      base64 = myBase64;
      imageName = myImageName;
      hasChanged = true;
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(nodeListener);
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

    return TouchableOpacity(
      onTap: () async {
        XFile? img = await ImageUtil.getImage();
        if (img != null) {
          List<int> imageBytes = await img.readAsBytes();
          String base64Image = base64Encode(imageBytes);
          setState(() {
            hasChanged = true;
            imageName = img.name;
            base64 = base64Image;
          });
          widget.onChanged(img.name, base64Image, img);
        }
      },
      child: Container(
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
              padding: EdgeInsets.only(left: 60, right: 10, top: hasChanged ? 18 : 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  hasChanged ? imageName : widget.title,
                  style: TextStyle(color: hasChanged ? AppColors.black : AppColors.grey, fontSize: 15),
                ),
              ),
            ),
            Positioned(
                top: 10,
                left: 60,
                child: Visibility(
                  visible: hasChanged,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                )),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: hasValue ? -10 : 0,
              left: 10,
              child: SizedBox(
                height: 60,
                width: 40,
                child: Visibility(
                  visible: !hasChanged,
                  child: Center(
                    child: Image.asset(
                      widget.icon,
                      color: hasChanged ? AppColors.primaryColor : AppColors.grey,
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 10,
                left: 10,
                child: Visibility(
                  visible: hasChanged,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.memory(
                          base64Decode(base64),
                          fit: BoxFit.cover,
                        )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
