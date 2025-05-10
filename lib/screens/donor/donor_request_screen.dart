import 'package:flutter/material.dart';

class DonorRequestScreen extends StatelessWidget {
  const DonorRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Permintaan Donor Darah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // List of donors
            _buildDonorCard(
              name: 'Muhammad Najwan',
              kantong: 2,
              hospital: 'RS Sardjito, Yogyakarta',
              bloodType: 'B+',
              isAvailable: true,
            ),
            const SizedBox(height: 12),
            _buildDonorCard(
              name: 'Muhammad Fahrul',
              kantong: 2,
              hospital: 'RS Sardjito, Yogyakarta',
              bloodType: 'B+',
              isAvailable: true,
            ),
            const SizedBox(height: 12),
            _buildDonorCard(
              name: 'Tegar Adi',
              kantong: 3,
              hospital: 'RS Sardjito, Yogyakarta',
              bloodType: 'B+',
              isAvailable: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorCard({
    required String name,
    required int kantong,
    required String hospital,
    required String bloodType,
    required bool isAvailable,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$kantong kantong',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hospital,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                // Button
                SizedBox(
                  height: 36,
                  child: ElevatedButton.icon(
                    onPressed: isAvailable ? () {} : null,
                    icon: Icon(
                      isAvailable ? Icons.favorite : Icons.hourglass_empty,
                      color: Colors.white,
                      size: 16,
                    ),
                    label: Text(
                      isAvailable ? 'Bersedia membantu' : 'Sudah dibantu',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAvailable ? Colors.red : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Right content - Blood type
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                bloodType,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}