import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/modules/home/controller/home_controller.dart';
import 'package:glive/modules/home/tabs/chat_tab.dart';
import 'package:glive/modules/home/tabs/home_tab.dart';
// import 'package:glive/modules/live/views/live_view.dart';
import 'package:glive/modules/create_post/views/create_post_view.dart';
import 'package:glive/modules/home/tabs/profile_tab.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/views/video_tab_view.dart';
import 'package:glive/widgets/AppBottomNavbar.dart';
import 'package:glive/widgets/AppPageBackground.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());
  final VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // videoController.initializeVideos();
    videoController.getPostsForYou(page: videoController.pageForYouCount.value, limit: videoController.limitForYouCount.value);
  }

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
      homeController.selectedIndex.value = newIndex;
      if (homeController.selectedIndex.value == 1) {
        videoController.handleBottomNavigationTap();
      } else if (homeController.selectedIndex.value == 2) {
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
      homeController.selectedIndex.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // body: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: AppColors.bgGradientColors,
      //       stops: [0.0891, 0.9926],
      //       transform: GradientRotation(263.49 * (3.14159 / 180)),
      //     ),
      //   ),
      //   width: double.infinity,
      //   height: double.infinity,
      //   child: _pages[_currentIndex],
      // ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: homeController.selectedIndex.value,
        onTap: _onItemTap,
      ),
      body: _pages[homeController.selectedIndex.value],
    );
  }
}
