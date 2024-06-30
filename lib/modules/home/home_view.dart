import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/modules/home/tabs/home_tab.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/views/video_tab_view.dart';
import 'package:glive/widgets/AppBottomNavbar.dart';

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
    videoController.initializeVideos();
  }

  final RxInt selectedIndex = 0.obs;
  final RxInt currentVideoIndex = 0.obs;

  final List<Widget> _pages = const [
    HomeTab(),
    VideoTabView(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  void _onItemTap(int newIndex) {
    setState(() {
      selectedIndex.value = newIndex;
      if (selectedIndex.value == 1) {
        videoController.handleBottomNavigationTap();
      } else {
        videoController.tapCount.value = 0;
      }
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
        currentIndex: selectedIndex.value,
        onTap: _onItemTap,
      ),
      body: _pages[selectedIndex.value],
    );
  }
}
