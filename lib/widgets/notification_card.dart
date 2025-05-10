import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String? actionText;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onActionPressed;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    this.actionText,
    this.icon,
    this.color,
    this.textColor,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(fontSize: 13.5),
          ),
          if (actionText != null) ...[
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onActionPressed ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: textColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              icon: Icon(icon ?? Icons.arrow_forward, size: 16),
              label: Text(
                actionText!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]
        ],
      ),
    );
  }
}