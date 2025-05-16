import 'package:flutter/material.dart';
import 'reward_success_notification.dart';

class DonorRewardDetailScreen extends StatefulWidget {
  final String voucherName;
  final String amount;
  final bool isRed;
  final int coinRequired;
  final String imagePath;

  const DonorRewardDetailScreen({
    super.key,
    required this.voucherName,
    required this.amount,
    required this.isRed,
    required this.coinRequired,
    required this.imagePath,
  });

  @override
  State<DonorRewardDetailScreen> createState() => _DonorRewardDetailScreenState();
}

class _DonorRewardDetailScreenState extends State<DonorRewardDetailScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isPhoneEntered = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final bool hasValue = _phoneController.text.isNotEmpty;
    if (hasValue != _isPhoneEntered) {
      setState(() {
        _isPhoneEntered = hasValue;
      });
    }
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }

  void _showSuccessNotification() {
    final String phoneNumber = _phoneController.text;
    if (phoneNumber.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return RewardSuccessNotification(
          amount: widget.amount,
          phoneNumber: phoneNumber,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Detail Reward',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Voucher Image Card
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                    ),                
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Voucher Name
              Text(
                '${widget.voucherName} ${widget.amount}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              // Coin Required
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Koin dibutuhkan : ${widget.coinRequired}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Terms and Conditions List
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                    child: Icon(
                      Icons.description_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 2),
                        _TermsItem(
                          text: 'Berlaku untuk semua operator (Telkomsel, Indosat, XL, Tri, Smartfren)',
                        ),
                        _TermsItem(
                          text: 'Klaim hanya bisa dilakukan 1x per hari',
                        ),
                        _TermsItem(
                          text: 'Pulsa akan dikirim maksimal 1x24 jam setelah klaim',
                        ),
                        _TermsItem(
                          text: 'Tidak dapat diuangkan',
                        ),
                        _TermsItem(
                          text: 'Pastikan nomor HP yang kamu daftarkan benar',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Phone Number Input
              const Text(
                'Masukkan No Telepon',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'No telepon',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Claim Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isPhoneEntered ? _showSuccessNotification : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isPhoneEntered 
                      ? const Color(0xFFB00020)
                      : Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Disable the button if phone is not entered, but keep the gray color
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.white,
                  ),
                  child: const Text(
                    'K L A I M  R E W A R D',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TermsItem extends StatelessWidget {
  final String text;

  const _TermsItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}