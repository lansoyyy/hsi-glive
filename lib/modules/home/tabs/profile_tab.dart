import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/utils/QuickDialog.dart';
import 'package:glive/widgets/AppInformationTextInput.dart';
import 'package:glive/widgets/AppPageBackground.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool inSettings = false;
  bool inedit = false;

  String field = '';
  @override
  Widget build(BuildContext context) {
    return field != ''
        ? editField()
        : inedit
            ? editProfile()
            : Scaffold(
                body: AppPageBackground(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          inSettings
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            inSettings = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextWidget(
                                        text: 'Edit',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            inedit = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.edit_square,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text: 'Profile',
                                        fontSize: 32,
                                        color: Colors.white,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            inSettings = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 75),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      50,
                                    ),
                                    topRight: Radius.circular(
                                      50,
                                    ),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.sp, right: 50.sp),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Image.asset(
                                            'assets/images/profile/Active Label.png',
                                            height: 25,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.sp,
                                      ),
                                      TextWidget(
                                        text: 'Anastasia',
                                        fontSize: 28.sp,
                                        color: Colors.white,
                                      ),
                                      TextWidget(
                                        text: '@anatas',
                                        fontSize: 16.sp,
                                        color: Colors.white30,
                                      ),
                                      SizedBox(
                                        height: 20.sp,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                text: 'Post',
                                                fontSize: 11.sp,
                                                color: Colors.white30,
                                              ),
                                              TextWidget(
                                                text: '90',
                                                fontSize: 18.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30.sp,
                                          ),
                                          SizedBox(
                                            height: 40.sp,
                                            child: const VerticalDivider(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.sp,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                text: 'Followers',
                                                fontSize: 11.sp,
                                                color: Colors.white30,
                                              ),
                                              TextWidget(
                                                text: '23',
                                                fontSize: 18.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30.sp,
                                          ),
                                          SizedBox(
                                            height: 40.sp,
                                            child: const VerticalDivider(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.sp,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                text: 'Following',
                                                fontSize: 11.sp,
                                                color: Colors.white30,
                                              ),
                                              TextWidget(
                                                text: '14',
                                                fontSize: 18.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.sp,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed(AppRoutes.CREATORCENTER);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 55.sp,
                                                decoration: BoxDecoration(
                                                  color: Colors.white38,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                                                  child: tileItem(
                                                    'Creator Center',
                                                    'image 119',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 125.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    tileItem(
                                                      'Wallet',
                                                      'image 120',
                                                    ),
                                                    tileItem(
                                                      'Item Bag',
                                                      'image 120 (1)',
                                                    ),
                                                    tileItem(
                                                      'My Post',
                                                      'image 120 (2)',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 125.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    tileItem(
                                                      'Task Center',
                                                      'image 120 (3)',
                                                    ),
                                                    tileItem(
                                                      'Activities',
                                                      'image 120 (4)',
                                                    ),
                                                    tileItem(
                                                      'Level',
                                                      'image 120 (5)',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            TouchableOpacity(
                                              onTap: () async {
                                                bool willLogout = await QuickDialog.logoutConfirmation(context);
                                                if (willLogout) {
                                                  final box = GetStorage();
                                                  box.remove("token");
                                                  Get.offNamed(AppRoutes.LOGIN);
                                                }
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: tileItem(
                                                    'Logout',
                                                    'image 119 (1)',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 140.sp, top: 75.sp),
                        child: const CircleAvatar(
                          minRadius: 75,
                          maxRadius: 75,
                          backgroundImage: AssetImage(
                            'assets/images/profile/Ellipse 717.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }

  Widget tileItem(String label, String img) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/profile/$img.png',
          height: 25,
        ),
        SizedBox(
          width: 15.sp,
        ),
        TextWidget(
          text: label,
          fontSize: 14,
          color: Colors.white,
        ),
        Expanded(
          child: SizedBox(
            width: 15.sp,
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget editProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    inedit = false;
                  });
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              TextWidget(
                text: 'Edit',
                fontSize: 18,
                color: Colors.white,
              ),
              ButtonWidget(
                color: AppColors.bluegreen,
                label: 'Save',
                fontSize: 12.sp,
                width: 70.sp,
                height: 30.sp,
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextWidget(
            text: 'Photo',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const Center(
          child: CircleAvatar(
            minRadius: 75,
            maxRadius: 75,
            child: Center(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: TextWidget(
            text: 'Information',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    50,
                  ),
                  topRight: Radius.circular(
                    50,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      informationTile('Name', 'Anastasia Santos'),
                      informationTile('Gender', 'Female'),
                      informationTile('Birthday', '2001 - 12 - 1'),
                      informationTile('Hometown', 'Manila, Phillipines'),
                      informationTile('Languages', 'English, Tagalog'),
                      informationTile('Sign', 'Scorpio'),
                      informationTile('Bio', 'Pretty Girl'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget informationTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          if (label != 'Birthday') {
            setState(() {
              field = label;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Bold',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            TextWidget(
              text: value,
              fontSize: 15.sp,
              color: Colors.black,
            ),
            SizedBox(
              width: 5.sp,
            ),
            const Icon(
              Icons.keyboard_arrow_right_sharp,
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController fname = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController houseno = TextEditingController();
  TextEditingController postalcode = TextEditingController();
  TextEditingController languages = TextEditingController();
  TextEditingController sign = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController street = TextEditingController();

  Widget editField() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      field = '';
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                TextWidget(
                  text: 'Edit',
                  fontSize: 18,
                  color: Colors.white,
                ),
                ButtonWidget(
                  color: AppColors.bluegreen,
                  label: 'Save',
                  fontSize: 12.sp,
                  width: 70.sp,
                  height: 30.sp,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextWidget(
              text: field,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          field == 'Name'
              ? name()
              : field == 'Languages'
                  ? lang()
                  : field == 'Sign'
                      ? signWidget()
                      : field == 'Bio'
                          ? bioWidget()
                          : field == 'Gender'
                              ? genderWidget()
                              : field == 'Hometown'
                                  ? hometownWidget()
                                  : const SizedBox(),
        ],
      ),
    );
  }

  Widget name() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'First Name',
              controller: fname,
              icon: Icons.email,
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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'Last Name',
              controller: lname,
              icon: Icons.email,
            ),
          ),
        ),
      ],
    );
  }

  Widget lang() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'Languages',
              controller: languages,
              icon: Icons.email,
            ),
          ),
        ),
      ],
    );
  }

  Widget signWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'Sign',
              controller: sign,
              icon: Icons.email,
            ),
          ),
        ),
      ],
    );
  }

  Widget bioWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'Bio',
              controller: bio,
              icon: Icons.email,
            ),
          ),
        ),
      ],
    );
  }

  String? dropdownValue;
  bool isFocused = false;

  Widget genderWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Container(
            height: 65.sp,
            width: MediaQuery.of(context).size.width,
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
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                dropdownColor: Colors.purple,
                hint: const Text(
                  'Select an option',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4'].map<DropdownMenuItem<String>>((String value) {
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
        )
      ],
    );
  }

  Widget hometownWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'House No.',
              controller: houseno,
              icon: Icons.email,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'Street',
              controller: street,
              icon: Icons.email,
            ),
          ),
        ),
        for (int i = 0; i < 4; i++)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              height: 65.sp,
              width: MediaQuery.of(context).size.width,
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
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  dropdownColor: Colors.purple,
                  hint: const Text(
                    'Select an option',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4'].map<DropdownMenuItem<String>>((String value) {
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
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: AppInformationTextInput(
              width: double.infinity,
              title: 'Postal Code',
              controller: postalcode,
              icon: Icons.email,
            ),
          ),
        ),
      ],
    );
  }
}
