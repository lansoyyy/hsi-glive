// ignore_for_file: file_names

import 'package:flutter/material.dart';

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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 35, 97, 147),
            Color.fromARGB(255, 72, 22, 82),
            Color.fromARGB(255, 43, 10, 46),
          ],
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Ensure the background is transparent
        currentIndex: currentIndex,

        onTap: onTap,
        items: _icons.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> icon = entry.value;

          return BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: index == 2
                ? Image.asset(
                    'assets/images/${icon['active']}.png',
                    width: 45,
                    height: 45,
                  )
                : ImageIcon(
                    AssetImage('assets/images/${icon[currentIndex == index ? 'active' : 'inactive']!}.png'),
                    size: 45,
                    color: currentIndex == index ? Colors.white : Colors.grey,
                  ),
            label: '',
          );
        }).toList(),
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
