import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  AppBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<Map<String, String>> _icons = [
    {'inactive': 'home', 'active': 'home'},
    {'inactive': 'video', 'active': 'video'},
    {'inactive': 'Group 48096052', 'active': 'Group 48096052'},
    {'inactive': 'chat', 'active': 'chat'},
    {'inactive': 'profile', 'active': 'profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black, // Ensure the background is transparent
      currentIndex: currentIndex,

      onTap: onTap,
      items: _icons.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, String> icon = entry.value;

        return BottomNavigationBarItem(
          backgroundColor: const Color(0xFF2F0032).withOpacity(0.95),
          icon: index == 2
              ? Image.asset(
                  'assets/images/${icon['active']}.png',
                  width: 45,
                  height: 45,
                )
              : ImageIcon(
                  AssetImage(
                      'assets/images/${icon[currentIndex == index ? 'active' : 'inactive']!}.png'),
                  size: 45,
                  color: currentIndex == index ? Colors.white : Colors.grey,
                ),
          label: '',
        );
      }).toList(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
