import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.onTabChange,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              // Background color of the bottom bar
              borderRadius: BorderRadius.circular(20), // Border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SalomonBottomBar(
              currentIndex: currentIndex,
              onTap: onTabChange,
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.home,
                    size: 26,
                  ),
                  title: const Text("Home"),
                  selectedColor: const Color.fromARGB(255, 29, 173, 53),
                  unselectedColor: Colors.grey,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.favorite,
                    size: 26,
                  ),
                  title: const Text("Likes"),
                  selectedColor: Colors.pink,
                  unselectedColor: Colors.grey,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.person,
                    size: 26,
                  ),
                  title: const Text("Profile"),
                  selectedColor: Colors.teal,
                  unselectedColor: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
