import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Widget child;
  final VoidCallback? onTap;

  MyButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(child: child),
      ),
    );
  }
}
