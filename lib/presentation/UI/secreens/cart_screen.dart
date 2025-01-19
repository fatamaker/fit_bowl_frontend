import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('cart'),
    );
  }
}
