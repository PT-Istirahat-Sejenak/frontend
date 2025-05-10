import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
// import 'package:lucide_icons/lucide_icons.dart';

class SeekerNotificationScreen extends StatelessWidget {
  const SeekerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.seekerNav),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationCard(
            title: 'Permintaan donor darah baru!',
            message:
                'Muhammad Najwan sedang butuh donor darah B+ sebanyak 2 kantong di RS Sardjito, Yogyakarta. Kondisinya sekarang mendesak.',
            actionText: 'Bersedia membantu',
            icon: Icons.thumbs_up_down,
            color: const Color(0xFFB00020),
            textColor: Colors.white,
          ),
          const SizedBox(height: 16),
          _buildNotificationCard(
            title: 'Jangan lupa donor darah 10 Maret 2025!',
            message:
                'Ingatkan alarm  dan persiapkan diri Anda untuk donor darah besok',
          ),
          const SizedBox(height: 16),
          _buildNotificationCard(
            title: 'Permintaan donor darah baru!',
            message:
                'Tegar Adi sedang butuh donor darah B+ sebanyak 3 kantong di RS Sardjito, Yogyakarta. Kondisinya sekarang mendesak.',
            actionText: 'Sudah dibantu',
            icon: Icons.thumbs_up_down,
            color: Colors.grey.shade400,
            textColor: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    String? actionText,
    IconData? icon,
    Color? color,
    Color? textColor,
  }) {
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: textColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              icon: Icon(icon, size: 16),
              label: Text(
                actionText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
