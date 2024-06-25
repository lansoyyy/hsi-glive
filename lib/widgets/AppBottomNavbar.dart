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
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: _icons.map((icon) {
        return BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
                'assets/images/${icon[currentIndex == _icons.indexOf(icon) ? 'active' : 'inactive']!}.png'),
            size: 45.sp,
            color: currentIndex == _icons.indexOf(icon)
                ? Colors.purple
                : Colors.black.withOpacity(0.6),
          ),
          label: '',
        );
      }).toList(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
