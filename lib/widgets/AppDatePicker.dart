// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/utils/CallbackModel.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/widgets/TouchableOpacity.dart';
import 'package:intl/intl.dart';

class AppDatePickerController extends ChangeNotifier {
  List<CallbackModel> loadFunctions = [];

  void loadData(List params) {
    for (var cb in loadFunctions) {
      cb.callback(params);
    }
  }

  void onLoadData(CallbackModel cb) {
    loadFunctions = loadFunctions.where((el) => el.id != cb.id).toList()..add(cb);
  }

  DateTime value = DateTime.now();
}

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({super.key, required this.width, required this.title, required this.onChanged, required this.controller, required this.icon});

  final double width;
  final String title;
  final String icon;
  final AppDatePickerController controller;
  final Function(DateTime) onChanged;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  FocusNode focusNode = FocusNode();

  String text = "";
  bool isFocused = false;

  DateTime myValue = DateTime.now();

  bool hasChanged = false;

  @override
  void initState() {
    focusNode.addListener(nodeListener);
    widget.controller.onLoadData(CallbackModel(id: randomString(24), callback: onLoadData));

    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(nodeListener);
    super.dispose();
  }

  void onLoadData(dynamic d) {
    if (!mounted) {
      return;
    }
    List params = d as List;
    String dateString = params[0]; //2024-03-06

    List splitted = dateString.split("-");
    int year = int.parse(splitted[0]);
    int month = int.parse(splitted[1]);
    int day = int.parse(splitted[2]);

    setState(() {
      myValue = DateTime(year, month, day);
      hasChanged = true;
    });
    widget.controller.value = myValue;
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
        DateTime? datetime = await showDatePicker(context: context, firstDate: DateTime(1969, 1, 1), lastDate: DateTime.now());
        if (datetime != null) {
          setState(() {
            myValue = datetime;
            hasChanged = true;
          });
          widget.onChanged(datetime);
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
                  hasChanged ? DateFormat('yyyy-MM-dd').format(myValue) : widget.title,
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
                child: Center(
                  child: Image.asset(
                    widget.icon,
                    color: hasChanged ? AppColors.primaryColor : AppColors.grey,
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
