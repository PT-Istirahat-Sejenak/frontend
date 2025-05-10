import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color iconColor;

  const BackButtonWidget({
    super.key,
    this.onPressed,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: iconColor),
      onPressed: onPressed ?? () => Navigator.pop(context),
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
    );
  }
}