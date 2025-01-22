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
          padding: const EdgeInsets.symmetric(vertical: 35),
          child: DotNavigationBar(
            margin: const EdgeInsets.all(8),
            itemPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuint,
            marginR: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            paddingR: const EdgeInsets.only(bottom: 5, top: 10),
            borderRadius: 30,
            enableFloatingNavBar: true,
            enablePaddingAnimation: true,
            currentIndex: currentIndex,
            onTap: onTabChange,
            dotIndicatorColor: Colors.black,
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
