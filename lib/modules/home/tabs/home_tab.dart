import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/routes.dart';
import 'package:glive/widgets/TextWidget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List categories = ['Nearby', 'Popular', 'Explore', 'Events'];

  List categoryImages = ['image 97', 'image 98', 'image 99', 'image 100'];

  String selected = 'Nearby';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 80.sp,
              height: 80.sp,
            ),
            SizedBox(
              width: 10.sp,
            ),
            TextWidget(
              text: 'GVLive GoodVibes',
              fontSize: 15.sp,
              color: Colors.white,
            ),
            Expanded(
              child: SizedBox(
                width: 10.sp,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.sp,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < categories.length; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = categories[i];
                      });
                    },
                    child: Container(
                      width: 100.sp,
                      height: 40.sp,
                      decoration: selected == categories[i]
                          ? BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFE630EF),
                                  Color(0xFF33E6F6),
                                ],
                                stops: [0.0, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(7.5),
                            )
                          : BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/${categoryImages[i]}.png',
                            height: 20.sp,
                            width: 20.sp,
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          TextWidget(
                            text: categories[i],
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Expanded(
            child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    opacity: 0.5,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/image 12.png',
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 30.sp,
                          width: 30.sp,
                          decoration: const BoxDecoration(
                              color: Colors.white38, shape: BoxShape.circle),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 10.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Group 56.png',
                            height: 40.sp,
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Carla Cruz',
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 2.sp,
                              ),
                              TextWidget(
                                text: '159k Followers',
                                fontSize: 8.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 10.sp,
                            ),
                          ),
                          Container(
                            height: 30.sp,
                            width: 70.sp,
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                TextWidget(
                                  text: '120k',
                                  fontSize: 8.sp,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}
