import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
  const InputSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        fillColor: const Color(0xFFF3F6ED),
        filled: true,
        prefixIcon: const Icon(Icons.search),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 2, color: Color(0xFFADEBB3))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 61, 60, 60),
            )),
      ),
    );
  }
}
