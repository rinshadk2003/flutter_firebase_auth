import 'package:flutter/material.dart';

class CoTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const CoTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$hintText is required';
        }

        if (hintText.toLowerCase() == 'email' &&
            !RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            ).hasMatch(value.trim())) {
          return 'Enter a valid email';
        }

        if (hintText.toLowerCase() == 'password' && value.length < 8) {
          return 'Password must be at least 8 characters';
        }

        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        fillColor: Colors.grey[200],
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: Colors.black),
        )
      ),
    );
  }
}
