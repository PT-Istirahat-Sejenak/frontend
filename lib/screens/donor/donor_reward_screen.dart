import 'package:flutter/material.dart';
import 'donor_reward_history_screen.dart';
import 'donor_reward_detail_screen.dart';

class DonorRewardScreen extends StatefulWidget {
  const DonorRewardScreen({super.key});

  @override
  State<DonorRewardScreen> createState() => _DonorRewardScreenState();
}

class _DonorRewardScreenState extends State<DonorRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reward',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Total Koin Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFD700),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.attach_money,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Total koin : 10',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // View My Rewards Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DonorRewardHistoryScreen(
                          hasRewards: false, // Change to true to show reward history
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB01212),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.card_giftcard, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Lihat Reward Saya',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Available Rewards Title
              const Text(
                'Daftar Reward Tersedia',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              // Grid of Rewards
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                  children: [
                    _buildRewardCard(
                      isRed: true,
                      amount: 'Rp5.000',
                    ),
                    _buildRewardCard(
                      isRed: false,
                      amount: 'Rp10.000',
                    ),
                    _buildRewardCard(
                      isRed: true,
                      amount: 'Rp5.000',
                    ),
                    _buildRewardCard(
                      isRed: false,
                      amount: 'Rp10.000',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardCard({required bool isRed, required String amount}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonorRewardDetailScreen(
              voucherName: 'Voucher Pulsa',
              amount: amount,
              isRed: isRed,
              coinRequired: 10,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card Image
            SizedBox(
              height: 80,
              child: isRed
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/voucher_red.png',
                          fit: BoxFit.contain,
                        ),
                        const Positioned(
                          top: 5,
                          right: 20,
                          child: Text(
                            '%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 15,
                          child: Text(
                            'VOUCHER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/voucher_purple.png',
                          fit: BoxFit.contain,
                        ),
                        const Positioned(
                          top: 5,
                          right: 20,
                          child: Text(
                            '%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 15,
                          child: Text(
                            'VOUCHER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Voucher Pulsa',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}