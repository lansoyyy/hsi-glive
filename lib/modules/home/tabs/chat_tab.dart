import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/HeaderWidget.dart';
import 'package:glive/widgets/TextWidget.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final searchController = TextEditingController();
  String nameSearched = '';
  bool chatstarted = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget(),
            SizedBox(
              height: 10.sp,
            ),
            chatstarted ? chatsWidget() : welcomeWidget()
          ],
        ),
        Visibility(
          visible: chatstarted,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset('assets/images/Group 48095997.png'),
                onPressed: () {
                  newChat();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextWidget(
            color: Colors.white,
            text: 'Chats',
            fontSize: 40,
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Center(
          child: Image.asset(
            'assets/images/Group 48096077.png',
            height: 250,
          ),
        ),
        SizedBox(
          height: 50.sp,
        ),
        Center(
          child: TextWidget(
            color: Colors.white,
            text: 'Start your first chat',
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Center(
          child: TextWidget(
            color: Colors.grey,
            text: 'Create chats for all the groups in your life.',
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Center(
          child: ButtonWidget(
            textColor: Colors.white,
            color: AppColors.bluegreen,
            width: 200,
            radius: 10,
            label: 'Start Chat',
            onPressed: () {
              setState(() {
                chatstarted = true;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget chatsWidget() {
    return SizedBox(
      height: 500.sp,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      minRadius: 30,
                      maxRadius: 30,
                      backgroundImage: AssetImage(
                        'assets/images/Ellipse 13.png',
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          color: Colors.white,
                          text: 'Hearttyy',
                          fontSize: 16.sp,
                        ),
                        TextWidget(
                          color: Colors.white,
                          text: 'Your dog is adorable ',
                          fontSize: 12.sp,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        TextWidget(
                          color: Colors.grey,
                          text: '1 minute ago',
                          fontSize: 10.sp,
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 10.sp,
                      ),
                    ),
                    const Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  newChat() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      TextWidget(
                        text: 'Create a new chat',
                        fontSize: 15,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black, fontFamily: 'Regular', fontSize: 14),
                          onChanged: (value) {
                            setState(() {
                              nameSearched = value;
                            });
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              hintText: 'Search People',
                              hintStyle: TextStyle(fontFamily: 'Bold'),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                          controller: searchController,
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.CHAT);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              minRadius: 30,
                              maxRadius: 30,
                              backgroundImage: AssetImage(
                                'assets/images/Ellipse 13.png',
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  color: Colors.black,
                                  text: 'Jean',
                                  fontSize: 16.sp,
                                ),
                                TextWidget(
                                  color: Colors.grey,
                                  text: '@jeanGVLive',
                                  fontSize: 12.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
