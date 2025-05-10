import 'package:flutter/material.dart';

class DonorRewardHistoryScreen extends StatelessWidget {
  final bool hasRewards;

  // Constructor that accepts a parameter to determine whether to show rewards or empty state
  const DonorRewardHistoryScreen({
    super.key, 
    this.hasRewards = false, // Default to empty state
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Reward Saya',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: hasRewards ? _buildRewardsList() : _buildEmptyState(),
    );
  }

  // Widget for displaying the reward history as shown in Image 1
  Widget _buildRewardsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildRewardItem(
            voucherName: 'Voucher Pulsa Rp5.000',
            status: 'Selesai',
            date: '11 Maret 2025',
            isRed: true,
          ),
          // Add more reward items here if needed
        ],
      ),
    );
  }

  // Widget for a single reward item in the history
  Widget _buildRewardItem({
    required String voucherName,
    required String status,
    required String date,
    required bool isRed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Voucher Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  isRed 
                      ? 'assets/images/voucher_red.png' 
                      : 'assets/images/voucher_purple.png',
                  fit: BoxFit.contain,
                ),
                const Positioned(
                  top: 5,
                  right: 15,
                  child: Text(
                    '%',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Voucher Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voucherName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Status : $status',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Tanggal : $date',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for displaying empty state message as shown in Image 2
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Anda belum pernah menukarkan koin untuk reward apa pun. Yuk kumpulkan koin dan tukarkan dengan e-voucher!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}