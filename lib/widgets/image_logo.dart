import 'package:flutter/material.dart';

class ImageLogo extends StatelessWidget {
  final double width;
  final double height;

  const ImageLogo({
    super.key,
    this.width = 80,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}