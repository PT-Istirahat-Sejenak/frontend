import 'package:flutter/material.dart';

class RewardSuccessNotification extends StatelessWidget {
  final String amount;
  final String phoneNumber;

  const RewardSuccessNotification({
    super.key,
    required this.amount,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Klaim Berhasil!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "E-Voucher pulsa senilai Rp$amount berhasil dikirim ke nomor ${_maskPhoneNumber(phoneNumber)}.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Tutup",
                style: TextStyle(
                  color: Color(0xFFE53935),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _maskPhoneNumber(String phone) {
    if (phone.length < 8) return phone;
    
    // Keep the first 2 digits and last 4 digits visible
    String firstPart = phone.substring(0, 2);
    String lastPart = phone.substring(phone.length - 4);
    String maskedPart = "*" * 6;
    
    return "$firstPart$maskedPart$lastPart";
  }
}