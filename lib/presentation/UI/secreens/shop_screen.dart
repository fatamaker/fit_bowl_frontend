import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreen();
}

class _ShopScreen extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('shop'),
    );
  }
}
