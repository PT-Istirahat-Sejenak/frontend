import 'package:flutter/material.dart';
import '../core/constant.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double? width;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB00020),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.03,
              fontFamily: AppText.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
