import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/home/tabs/home_tab.dart';
import 'package:glive/modules/home/tabs/profile_tab.dart';
import 'package:glive/widgets/AppBottomNavbar.dart';

import 'tabs/chat_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeTab(),
    SizedBox(),
    SizedBox(),
    ChatTab(),
    ProfileTab()
  ];

  void _onItemTap(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.gradiants,
              stops: const [0.0, 1.0],
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
