import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/notification_card.dart';
// import 'package:lucide_icons/lucide_icons.dart';

class SeekerNotificationScreen extends StatelessWidget {
  const SeekerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          NotificationCard(
            title: 'Pendonor ditemukan!',
            message:
                'Rila Najjakha (B+) bersedia membantu. Untuk lebih jelasnya, Anda dapat menghubungi calon pendonor secara langsung.',
            actionText: 'Chat Sekarang',
            icon: Icons.message_outlined,
            color: const Color(0xFFB00020),
            textColor: Colors.white,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
