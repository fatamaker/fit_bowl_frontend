import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  final int currentIndex;

  // ignore: prefer_const_constructors_in_immutables
  BottomNavBar({
    super.key,
    required this.onTabChange,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 143,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: DotNavigationBar(
            backgroundColor: const Color(0xFFADEBB3),
            margin: const EdgeInsets.all(8),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuint,
            marginR: const EdgeInsets.symmetric(vertical: 0),
            itemPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            borderRadius: 30,
            enableFloatingNavBar: true,
            enablePaddingAnimation: true,
            currentIndex: currentIndex,
            onTap: onTabChange,
            items: [
              /// Home
              DotNavigationBarItem(
                icon: const Icon(Icons.home),
                selectedColor: Colors.purple,
              ),

              /// Likes
              DotNavigationBarItem(
                icon: const Icon(Icons.favorite),
                selectedColor: Colors.pink,
              ),

              /// Profile
              DotNavigationBarItem(
                icon: const Icon(Icons.person),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        );
      },
    );
  }
}
