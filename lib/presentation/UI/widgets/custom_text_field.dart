// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isObscure;
  final Widget? suffixIcon;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.isObscure = false,
    this.suffixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFADEBB3).withOpacity(0.5),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
