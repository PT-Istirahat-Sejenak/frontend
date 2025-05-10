import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
// import 'package:lucide_icons/lucide_icons.dart';

class DonorHistoryScreen extends StatelessWidget {
  const DonorHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.donorNav),
        ),
        title: const Text(
          'Riwayat Donor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.check_circle, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Berhasil Donor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.card_giftcard, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '+10 koin',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const _InfoRow(
                icon: Icons.location_on_outlined,
                text: 'PMI Kota Yogyakarta',
              ),
              const SizedBox(height: 8),
              const _InfoRow(
                icon: Icons.calendar_today_outlined,
                text: '10 Januari 2025',
              ),
              const SizedBox(height: 8),
              const _InfoRow(
                icon: Icons.access_time,
                text: '09.30 WIB',
              ),
              const SizedBox(height: 8),
              const _InfoRow(
                icon: Icons.format_list_numbered,
                text: 'Donor ke-1',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 13.5),
        ),
      ],
    );
  }
}
