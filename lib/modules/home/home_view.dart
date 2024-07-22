import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/modules/home/tabs/chat_tab.dart';
import 'package:glive/modules/home/tabs/home_tab.dart';
// import 'package:glive/modules/live/views/live_view.dart';
import 'package:glive/modules/create_post/views/create_post_view.dart';
import 'package:glive/modules/home/tabs/profile_tab.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/views/video_tab_view.dart';
import 'package:glive/widgets/AppBottomNavbar.dart';
import 'package:glive/widgets/AppPageBackground.dart';

import 'tabs/chat_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // videoController.initializeVideos();
    videoController.getPostsForYou(page: videoController.pageForYouCount.value, limit: videoController.limitForYouCount.value);
  }

  final RxInt selectedIndex = 0.obs;
  Rx isLivePageFullScreen = false.obs;

  final List<Widget> _pages = const [
    HomeTab(),
    VideoTabView(),
    AppPageBackground(child: SizedBox()),
    ChatTab(),
    ProfileTab(),
  ];

  void _onItemTap(int newIndex) {
    setState(() {
      selectedIndex.value = newIndex;
      if (selectedIndex.value == 1) {
        videoController.handleBottomNavigationTap();
      } else if (selectedIndex.value == 2) {
        _openLivePage();
      } else {
        videoController.tapCount.value = 0;
      }
    });
  }

  void _openLivePage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePostView(),
        fullscreenDialog: true,
      ),
    );

    setState(() {
      selectedIndex.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0XFF2F0032),
                Color(0XFF00272A),
              ],
              stops: [0.0, 1.0],
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: _pages[_currentIndex],
        ),
      ),
      */
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: _onItemTap,
      ),
      body: _pages[selectedIndex.value],
    );
  }
}
