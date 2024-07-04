import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/widgets/TextWidget.dart';

import '../../../routes.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
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
                    onPressed: () {},
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
                                  Get.toNamed(RouteNames.creatorcenter);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 55.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.sp, right: 15.sp),
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
                                  padding: EdgeInsets.only(
                                      left: 15.sp, right: 15.sp),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                  padding: EdgeInsets.only(
                                      left: 15.sp, right: 15.sp),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: tileItem(
                                  'Logout',
                                  'image 119 (1)',
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
}
