// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/utils/CallbackModel.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

class AppSelectOption {
  String label = "";
  String value = "";

  AppSelectOption({required this.label, required this.value});
}

class AppSelectPickerController extends ChangeNotifier {
  List<CallbackModel> loadFunctions = [];

  AppSelectOption currentOption = AppSelectOption(label: "", value: "");

  void loadData(List params) {
    currentOption.value = params[0];
    for (var cb in loadFunctions) {
      cb.callback(params);
    }
  }

  void onLoadData(CallbackModel cb) {
    loadFunctions = loadFunctions.where((el) => el.id != cb.id).toList()..add(cb);
  }
}

class AppSelectPicker extends StatefulWidget {
  const AppSelectPicker({
    super.key,
    required this.width,
    required this.title,
    required this.onChanged,
    required this.controller,
    required this.icon,
    required this.options,
  });

  final double width;
  final String title;
  final String icon;
  final List<AppSelectOption> options;
  final AppSelectPickerController controller;
  final Function(AppSelectOption) onChanged;

  @override
  State<AppSelectPicker> createState() => _AppSelectPickerState();
}

class _AppSelectPickerState extends State<AppSelectPicker> {
  AppSelectOption? selectedOption;

  bool hasChanged = false;

  @override
  void initState() {
    widget.controller.onLoadData(CallbackModel(id: randomString(24), callback: onLoadData));
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.controller.onLoadData(CallbackModel(id: randomString(24), callback: onLoadData));
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onLoadData(dynamic d) {
    List params = d as List;
    String value = params[0];
    for (AppSelectOption selection in widget.options) {
      if (selection.value == value) {
        onSelect(selection);
      }
    }
  }

  void onSelect(AppSelectOption item) {
    if (!mounted) {
      if (widget.title == "Disbursement Source") {
        log("On select? ${item.value}");
      }
      return;
    }
    setState(() {
      hasChanged = true;
      selectedOption = item;
    });
    widget.controller.currentOption = item;
    widget.onChanged(item);
  }

  void showSelectPicker() {
    showDialog(
      context: context,
      barrierDismissible: true, // Dialog can be dismissed by tapping outside

      builder: (BuildContext context) {
        return Container(
          height: heightScreen(),
          width: widthScreen(),
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TapRegion(
                onTapOutside: (ev) {
                  Navigator.pop(context);
                },
                child: Container(
                  width: widthScreen() - 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
                    BoxShadow(color: rgba(0, 0, 0, 0.5), blurRadius: 5.0, offset: const Offset(0.0, 2)),
                  ]),
                  child: Column(
                    children: [
                      Container(
                        width: widthScreen() - 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            color: AppColors.primaryColor),
                        child: Center(
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                      ColumnBuilder(
                          itemBuilder: (context, index) {
                            AppSelectOption item = widget.options[index];

                            return Column(
                              children: [
                                TouchableOpacity(
                                    onTap: () {
                                      Navigator.pop(context);
                                      onSelect(item);
                                    },
                                    child: Container(
                                      width: widthScreen() - 40,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                      child: Text(
                                        item.label,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: HexColor("#262626"),
                                          fontSize: 14,
                                        ),
                                      ),
                                    )),
                                Container(
                                  height: 1,
                                  width: widthScreen() - 100,
                                  color: HexColor("#262626").withOpacity(0.1),
                                )
                              ],
                            );
                          },
                          itemCount: widget.options.length)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasValue = selectedOption != null;

    double myWidth = widget.width;
    if (myWidth < 0) {
      myWidth = 0;
    }

    return TouchableOpacity(
      onTap: () async {
        showSelectPicker();
      },
      child: Container(
        height: 60,
        width: myWidth,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              height: 60,
              width: myWidth,
              padding: EdgeInsets.only(left: 60, right: 10, top: hasValue ? 18 : 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  hasValue ? selectedOption!.label : widget.title,
                  style: TextStyle(color: hasValue ? AppColors.black : AppColors.grey, fontSize: 15),
                ),
              ),
            ),
            Positioned(
                top: 10,
                left: 60,
                child: Visibility(
                  visible: hasValue,
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
      ),
    );
  }
}
