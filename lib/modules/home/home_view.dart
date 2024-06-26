import 'package:flutter/material.dart';
import 'package:glive/modules/home/tabs/home_tab.dart';
import 'package:glive/widgets/AppBottomNavbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomeTab(), SizedBox(), SizedBox(), SizedBox(), SizedBox()];

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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8B008B), // Darker purple
                Color(0xFF008B8B), // Darker teal
              ],
              stops: [0.0, 1.0],
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
