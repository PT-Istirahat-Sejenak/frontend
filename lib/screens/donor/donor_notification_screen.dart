import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/notification_card.dart';
// import 'package:lucide_icons/lucide_icons.dart';

class DonorNotificationScreen extends StatelessWidget {
  const DonorNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.donorNav),
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
          NotificationCard(
            title: 'Permintaan donor darah baru!',
            message:
                'Muhammad Najwan sedang butuh donor darah B+ sebanyak 2 kantong di RS Sardjito, Yogyakarta. Kondisinya sekarang mendesak.',
            actionText: 'Bersedia membantu',
            icon: Icons.thumbs_up_down,
            color: const Color(0xFFB00020),
            textColor: Colors.white,
          ),
          const SizedBox(height: 16),
          NotificationCard(
            title: 'Jangan lupa donor darah 10 Maret 2025!',
            message:
                'Ingatkan alarm  dan persiapkan diri Anda untuk donor darah besok',
          ),
          const SizedBox(height: 16),
          NotificationCard(
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
}
