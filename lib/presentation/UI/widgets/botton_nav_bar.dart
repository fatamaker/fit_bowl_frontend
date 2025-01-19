import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Color(0xFFADEBB3),
        activeColor: const Color.fromARGB(255, 61, 60, 60),
        tabActiveBorder: Border.all(color: Color(0xFFADEBB3)),
        tabBackgroundColor: Color(0xFFADEBB3),
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (values) => onTabChange!(values),
        tabs: const [
          GButton(
            icon: Icons.home,
            iconColor: Colors.grey,
            text: 'Shop',
          ),
          GButton(
            icon: Icons.shopping_bag_rounded,
            iconColor: Colors.grey,
            text: 'Cart',
          ),
        ],
      ),
    );
  }
}
