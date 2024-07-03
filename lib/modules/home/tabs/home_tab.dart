import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/models/app/GiftModel.dart';
import 'package:glive/routes.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/HeaderWidget.dart';
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

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderWidget(),
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
            return GestureDetector(
              onTap: () {
                sendGift();
              },
              child: Card(
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
              ),
            );
          },
        ))
      ],
    );
  }

  sendGift() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(25.0),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF8B008B), // Darker purple
                  Color(0xFF008B8B), // Darker teal
                ],
                stops: [0.0, 1.0],
              ),
            ),
            height: 325.sp,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/gifts/gift.png',
                            height: 24.sp,
                            width: 24.sp,
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          TextWidget(
                            text: 'Send Gifts to Gamers230',
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 5.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonWidget(
                            width: 75.sp,
                            height: 28.sp,
                            fontSize: 10,
                            label: 'Regular',
                            onPressed: () {},
                          ),
                          ButtonWidget(
                            color: const Color(0XFF60E7F6),
                            width: 100.sp,
                            height: 28.sp,
                            fontSize: 10,
                            label: 'Coins Balance: 275',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  sendGiftConfirmation(giftList[i]);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/gifts/${giftList[i].image}.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    TextWidget(
                                      text: giftList[i].name,
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/gifts/coin.png',
                                          height: 15,
                                          width: 15,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        TextWidget(
                                          text: giftList[i].coins.toString(),
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 4; i < giftList.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  sendGiftConfirmation(giftList[i]);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/gifts/${giftList[i].image}.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    TextWidget(
                                      text: giftList[i].name,
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/gifts/coin.png',
                                          height: 15,
                                          width: 15,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        TextWidget(
                                          text: giftList[i].coins.toString(),
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  sendGiftConfirmation(GiftModel gift) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(25.0),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8B008B), // Darker purple
                    Color(0xFF008B8B), // Darker teal
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              height: 400.sp,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(color: Colors.white, width: 0.5),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/gifts/gift.png',
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            TextWidget(
                              text: 'Send Gifts to Gamers230',
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 5.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            ButtonWidget(
                              color: const Color(0XFF60E7F6),
                              width: 100.sp,
                              height: 28.sp,
                              fontSize: 10,
                              label: 'Coins Balance: 275',
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Image.asset(
                          'assets/images/gifts/${gift.image}.png',
                          height: 75,
                          width: 75,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/gifts/coin.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            TextWidget(
                              text: gift.coins.toString(),
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        TextWidget(
                          text: 'Star in a ${gift.name}',
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              activeColor: Colors.white,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            TextWidget(
                              align: TextAlign.start,
                              text: '''
By clicking Send Gifts,\nyou agree to spend of your GVLive Coins.
''',
                              fontSize: 8.sp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        ButtonWidget(
                          radius: 15,
                          label: 'Send',
                          onPressed: () {
                            Navigator.pop(context);
                            recharge();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  recharge() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(25.0),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8B008B), // Darker purple
                    Color(0xFF008B8B), // Darker teal
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              height: 400.sp,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(color: Colors.white, width: 0.5),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/gifts/recharge.png',
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            TextWidget(
                              text: 'Select charge amount',
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 5.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            ButtonWidget(
                              color: const Color(0XFF60E7F6),
                              width: 100.sp,
                              height: 28.sp,
                              fontSize: 10,
                              label: 'Coins Balance: 275',
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        SizedBox(
                          height: 175.sp,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Image.asset(
                                      'assets/images/gifts/charges.png',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        ButtonWidget(
                          color: const Color(0XFF60E7F6),
                          radius: 15,
                          label: 'Recharge',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  List<GiftModel> giftList = [
    GiftModel(image: 'box', name: 'Box', coins: 5),
    GiftModel(image: 'highfive', name: 'High-five', coins: 10),
    GiftModel(image: 'pettoys', name: 'Pet Toys', coins: 25),
    GiftModel(image: 'treats', name: 'Treats', coins: 75),
    GiftModel(image: 'award', name: 'Award', coins: 150),
    GiftModel(image: 'hugheart', name: 'Hug Heart', coins: 500),
    GiftModel(image: 'trophy', name: 'Trophy', coins: 1000),
    GiftModel(image: 'crown', name: 'Crown', coins: 2000),
  ];
}
