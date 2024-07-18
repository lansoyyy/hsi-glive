import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/network/ApiEndpoints.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/ImageUtil.dart';
import 'package:glive/utils/ToastHelper.dart';
import 'package:glive/widgets/AppTextInput.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:glive/widgets/TouchableOpacity.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/AppInformationTextInput.dart';

class UserInfoTab extends StatefulWidget {
  const UserInfoTab(
      {super.key, required this.updateStatus, required this.onRegister});

  final Function updateStatus;
  final Function onRegister;

  @override
  State<UserInfoTab> createState() => _UserInfoTabState();
}

class _UserInfoTabState extends State<UserInfoTab> {
  TextEditingController fname = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController lname = TextEditingController();

  String dropdownValue = "Select";
  bool isFocused = false;

  String lastNameError = "";
  String middleNameError = "";
  String firstNameError = "";
  String genderError = "";
  String profileError = "";

  String imagePath = "";

  void setProfileError(String message) {
    if (profileError.isEmpty) {
      setState(() {
        profileError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          profileError = "";
        });
      });
    }
  }

  void setGenderError(String message) {
    if (genderError.isEmpty) {
      setState(() {
        genderError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          genderError = "";
        });
      });
    }
  }

  void setLastNameError(String message) {
    if (lastNameError.isEmpty) {
      setState(() {
        lastNameError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          lastNameError = "";
        });
      });
    }
  }

  void setMiddleNameError(String message) {
    if (middleNameError.isEmpty) {
      setState(() {
        middleNameError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          middleNameError = "";
        });
      });
    }
  }

  void setFirstNameError(String message) {
    if (firstNameError.isEmpty) {
      setState(() {
        firstNameError = message;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          firstNameError = "";
        });
      });
    }
  }

  void updateStatus() {
    widget.updateStatus(
        imagePath, lname.text, mname.text, fname.text, dropdownValue);
  }

  double headerHeight = 135.5;

  double interestContentHeight = 300.sp;
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.sp,
            ),
            TouchableOpacity(
              onTap: () async {
                if (imagePath.isNotEmpty) {
                  XFile imageFile =
                      await ImageUtil.optionsWithRemove(context, () {
                    setState(() {
                      imagePath = "";
                    });
                    updateStatus();
                  });
                  setState(() {
                    imagePath = imageFile.path;
                  });
                  updateStatus();
                } else {
                  XFile imageFile = await ImageUtil.options(context);
                  setState(() {
                    imagePath = imageFile.path;
                  });
                  updateStatus();
                }
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.sp,
                            color: profileError.isNotEmpty
                                ? Colors.red
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(1000)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10000),
                      child: imagePath.isEmpty
                          ? Image.asset(
                              "assets/images/default_profile.png",
                              height: 150.sp,
                              width: 150.sp,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagePath),
                              height: 150.sp,
                              width: 150.sp,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 12.sp,
                      right: 10.sp,
                      child: Image.asset(
                        "assets/images/small_edit.png",
                        height: 24.sp,
                        width: 24.sp,
                      ))
                ],
              ),
            ),
            Visibility(
              visible: profileError.isNotEmpty,
              child: Padding(
                padding: REdgeInsets.only(top: 20.sp),
                child: Text(
                  profileError,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(
              height: 40.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 68.sp,
                    width: widthScreen(),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.sp,
                            color: lastNameError.isNotEmpty
                                ? Colors.red
                                : HexColor("#5A5A5A")),
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white.withOpacity(0.10)),
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Name",
                          style: TextStyle(
                              color: HexColor("#989898"),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: lname,
                          inputFormatters: [
                            NoNumbersAndSpecialCharactersFormatter()
                          ],
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Enter Last Name",
                              hintStyle: TextStyle(
                                  color: HexColor("#5B5B5B"), fontSize: 15.sp)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setLastNameError("Please enter last name");
                              //return 'Please enter an email address';
                            }
                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!)) {
                              setLastNameError(
                                  "Please enter a valid last name");
                            }
                            return null;
                          },
                          onChanged: (value) {
                            updateStatus();
                          },
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: lastNameError.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.sp),
                        child: Text(
                          lastNameError,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 13.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 68.sp,
                    width: widthScreen(),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.sp,
                            color: middleNameError.isNotEmpty
                                ? Colors.red
                                : HexColor("#5A5A5A")),
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white.withOpacity(0.10)),
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Middle Name",
                          style: TextStyle(
                              color: HexColor("#989898"),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: mname,
                          inputFormatters: [
                            NoNumbersAndSpecialCharactersFormatter()
                          ],
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Enter Middle Name",
                              hintStyle: TextStyle(
                                  color: HexColor("#5B5B5B"), fontSize: 15.sp)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setMiddleNameError("Please enter middle name");
                              //return 'Please enter an email address';
                            }
                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!)) {
                              setMiddleNameError(
                                  "Please enter a valid middle name");
                            }
                            return null;
                          },
                          onChanged: (value) {
                            updateStatus();
                          },
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: middleNameError.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.sp),
                        child: Text(
                          middleNameError,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 13.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 68.sp,
                    width: widthScreen(),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.sp,
                            color: firstNameError.isNotEmpty
                                ? Colors.red
                                : HexColor("#5A5A5A")),
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white.withOpacity(0.10)),
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: TextStyle(
                              color: HexColor("#989898"),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: fname,
                          inputFormatters: [
                            NoNumbersAndSpecialCharactersFormatter()
                          ],
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Enter Name",
                              hintStyle: TextStyle(
                                  color: HexColor("#5B5B5B"), fontSize: 15.sp)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setFirstNameError("Please enter first name");
                              //return 'Please enter an email address';
                            }
                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!)) {
                              setFirstNameError(
                                  "Please enter a valid first name");
                            }
                            return null;
                          },
                          onChanged: (value) {
                            updateStatus();
                          },
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: firstNameError.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.sp),
                        child: Text(
                          firstNameError,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 13.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 20),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 65.sp,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: isFocused
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.transparent,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                              color: genderError.isNotEmpty
                                  ? Colors.red
                                  : HexColor("#5A5A5A"),
                              width: 1.sp),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 25.sp,
                              bottom: 8.sp,
                              left: 14.sp,
                              right: 15.sp),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            dropdownColor: HexColor("#01262A").withOpacity(0.8),
                            hint: Text(
                              'Select',
                              style: TextStyle(color: HexColor("#5A5A5A")),
                            ),
                            icon: Transform.rotate(
                              angle: -1.6,
                              child: const Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: const SizedBox(),
                            isDense:
                                false, // Adjusts the height of the dropdown
                            isExpanded:
                                true, // Makes the dropdown take up full width
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue.toString();
                              });
                              updateStatus();
                            },

                            items: <String>[
                              'Select',
                              'male',
                              'female',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: value == "Select"
                                        ? HexColor("#5A5A5A")
                                        : Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: genderError.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child: Text(
                              genderError,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ))
                    ],
                  ),
                  Positioned(
                    top: 10.sp,
                    left: 15.sp,
                    child: Text(
                      "Gender",
                      style: TextStyle(
                          color: HexColor("#989898"),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (heightScreen() -
                          (headerHeight +
                              interestContentHeight +
                              50.sp +
                              80.sp)) >
                      0
                  ? heightScreen() -
                      (headerHeight + interestContentHeight + 200.sp + 150.sp)
                  : 0,
            ),
            /* ButtonWidget(
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
            ), */

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: TouchableOpacity(
                onTap: () async {
                  if (dropdownValue == "Select") {
                    setGenderError("Please select a gender");
                  }
                  if (imagePath.isEmpty) {
                    setProfileError("Please upload a picture");
                  }

                  if (_formKey2.currentState!.validate()) {
                    // showSuccessDialog();

                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(fname.text) ||
                        fname.text.isEmpty) {
                      return;
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(mname.text) ||
                        mname.text.isEmpty) {
                      return;
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(lname.text) ||
                        lname.text.isEmpty) {
                      return;
                    }

                    if (dropdownValue == "Select") {
                      return;
                    }

                    if (imagePath.isEmpty) {
                      return;
                    }

                    updateUserProfile();
                  }
                },
                child: Container(
                  width: widthScreen(),
                  height: 68.sp,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: HexColor("#262626"), fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
      const Duration(milliseconds: 3000),
    );

    Navigator.pop(context);

    // Here

    Get.toNamed(RouteNames.termspage);
    showtermsandconditionsDialog();
  }

  showtermsandconditionsDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white.withOpacity(0.75),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'By tapping "Agree and continue", you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' and acknowledge that you have read our ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ' to learn how we collect, use, and share your data.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    height: 43,
                    width: 166,
                    fontSize: 14,
                    color: const Color(0XFF0A9AAA),
                    radius: 10,
                    textColor: Colors.white,
                    label: 'Agree and Continue',
                    onPressed: () {
                      Get.offNamed(RouteNames.login);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> updateUserProfile() async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(ApiEndpoints.updateprofile);
    final req = http.MultipartRequest('PUT', url)
      ..fields['firstName'] = fname.text
      ..fields['lastName'] = lname.text
      ..fields['middleName'] = mname.text
      ..fields['address[houseNumber]'] = ' '
      ..fields['gender'] = dropdownValue;

    req.headers['Ocp-Apim-Subscription-Key'] =
        'f3afff9001fd47ea9ea6e11255d8445c';
    req.headers['Authorization'] = 'Bearer ${prefs.get('access')}';

    final stream = await req.send();
    final res = await http.Response.fromStream(stream);
    final status = res.statusCode;
    if (status == 200) {
      showSuccessDialog();
    } else {
      ToastHelper.error('Something went wrong!');
    }

    print(jsonDecode(res.body));
  }
}

class NoNumbersAndSpecialCharactersFormatter extends TextInputFormatter {
  final RegExp _regExp =
      RegExp(r'[A-Za-z\s]'); // Allows only letters and spaces

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filteredText =
        newValue.text.split('').where((char) => _regExp.hasMatch(char)).join();

    int selectionIndex = newValue.selection.end;

    // Adjust the selection index to be within the bounds of the filtered text
    if (selectionIndex > filteredText.length) {
      selectionIndex = filteredText.length;
    }

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
