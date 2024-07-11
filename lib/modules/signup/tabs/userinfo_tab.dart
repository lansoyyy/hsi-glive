import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/ToastHelper.dart';
import 'package:glive/widgets/AppTextInput.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';

import '../../../widgets/AppInformationTextInput.dart';

class UserInfoTab extends StatefulWidget {
  const UserInfoTab({super.key});

  @override
  State<UserInfoTab> createState() => _UserInfoTabState();
}

class _UserInfoTabState extends State<UserInfoTab> {
  TextEditingController fname = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController lname = TextEditingController();

  String? dropdownValue;
  bool isFocused = false;

  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.sp,
              ),
              const Stack(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 150,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Center(
                  child: AppInformationTextInput(
                    width: double.infinity,
                    title: 'Last Name',
                    controller: lname,
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a last name';
                      }
                      // Check if the name consists of alphabetic characters only
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'Please enter a valid last name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Center(
                  child: AppInformationTextInput(
                    width: double.infinity,
                    title: 'Middle Name',
                    controller: mname,
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a middle name';
                      }
                      // Check if the name consists of alphabetic characters only
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'Please enter a valid middle name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Center(
                  child: AppInformationTextInput(
                    width: double.infinity,
                    title: 'First Name',
                    controller: fname,
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a first name';
                      }
                      // Check if the name consists of alphabetic characters only
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'Please enter a valid first name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  height: 65.sp,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.30),
                    boxShadow: [
                      BoxShadow(
                        color: isFocused
                            ? Colors.grey.withOpacity(0.30)
                            : Colors.transparent,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    border: Border.all(color: Colors.white, width: 0.30),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      dropdownColor: Colors.pink[200],
                      hint: const Text(
                        'Select Gender',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.white,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: const SizedBox(),
                      isDense: false, // Adjusts the height of the dropdown
                      isExpanded: true, // Makes the dropdown take up full width
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Male',
                        'Female',
                        'Others',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              ButtonWidget(
                height: 55,
                radius: 10,
                width: 350.sp,
                label: 'Register',
                onPressed: () {
                  if (dropdownValue != null) {
                    if (_formKey2.currentState!.validate()) {
                      showSuccessDialog();
                    }
                  } else {
                    ToastHelper.error('Please select a gender.');
                  }
                },
              ),
              SizedBox(
                height: 50.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSuccessDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/check.png',
                    height: 150,
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  TextWidget(
                    text: 'Successful',
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  TextWidget(
                    text: '''
You are already registered.
Enjoy using our app!
''',
                    fontSize: 14,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  const SpinKitCircle(
                    color: Color(0xFFC30FCC),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(seconds: 3),
    );

    Navigator.pop(context);

    Get.offNamed(RouteNames.login);
  }
}
