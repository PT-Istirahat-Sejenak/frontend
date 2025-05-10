import 'package:flutter/material.dart';
import '../core/constant.dart';

class ForgetPasswordButton extends StatelessWidget {
  final VoidCallback onTap;

  const ForgetPasswordButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 12,
      child: GestureDetector(
        onTap: onTap,
        child: const Text(
          "Lupa kata sandi?",
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppText.fontFamily,
            fontWeight: FontWeight.w600,
            color: Color(0xFF013C98),
          ),
        ),
      ),
    );
  }
}
