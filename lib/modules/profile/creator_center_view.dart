import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/profile/tabs/moment.dart';
import 'package:glive/modules/profile/tabs/post.dart';
import 'package:glive/modules/profile/tabs/profile.dart';
import 'package:glive/modules/profile/tabs/video.dart';
import 'package:glive/widgets/TextWidget.dart';

class CreatorCenterView extends StatelessWidget {
  const CreatorCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.gradients,
                stops: const [0.0, 1.0],
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Stack(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 20.sp, right: 50.sp),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: AppBar().preferredSize.width,
                                  child: const TabBar(
                                    indicatorColor: Colors.pink,
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    unselectedLabelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    isScrollable: true,
                                    tabs: [
                                      Tab(
                                        text: 'Profile',
                                      ),
                                      Tab(
                                        text: 'Post',
                                      ),
                                      Tab(
                                        text: 'Video',
                                      ),
                                      Tab(
                                        text: 'Moment',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              const Expanded(
                                child: TabBarView(
                                  children: [
                                    Profile(),
                                    Post(),
                                    Video(),
                                    Moment(),
                                  ],
                                ),
                              ),
                            ],
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
        ),
      ),
    );
  }
}
