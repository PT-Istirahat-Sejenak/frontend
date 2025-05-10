import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/custom_text_field.dart';

class DonorNewPasswordScreen extends StatefulWidget {
  const DonorNewPasswordScreen({super.key});

  @override
  State<DonorNewPasswordScreen> createState() => _DonorNewPasswordScreenState();
}

class _DonorNewPasswordScreenState extends State<DonorNewPasswordScreen> {
  final TextEditingController _donorPasswordController = TextEditingController();
  final TextEditingController _donorConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _donorPasswordController.dispose();
    _donorConfirmPasswordController.dispose();
    super.dispose();
  }

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
              // Back button and title
              Row(
                children: [
                  BackButtonWidget(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.donorVerificationCode);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Kata Sandi Baru',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 25),
              
              // Title
              Center(
                child: Text(
                  'Buat Kata Sandi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Description
              Center(
                child: Text(
                  'Pastikan kata sandi sesuai kriteria keamanan\ndan belum pernah digunakan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              
              const SizedBox(height: 25),
              
              // New password field using CustomTextField
              CustomTextField(
                label: 'Masukkan kata sandi baru',
                controller: _donorPasswordController,
                isPassword: true,
              ),
              
              const SizedBox(height: 16),
              
              // Confirm password field using CustomTextField
              CustomTextField(
                label: 'Konfirmasi kata sandi',
                controller: _donorConfirmPasswordController,
                isPassword: true,
              ),
              
              const SizedBox(height: 25),
              
              // Save button
              PrimaryButton(
                text: 'SIMPAN',
                onPressed: () {
                  if (_donorPasswordController.text.isEmpty || 
                      _donorConfirmPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Harap isi semua kolom')),
                    );
                    return;
                  }
                  
                  if (_donorPasswordController.text != _donorConfirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kata sandi tidak cocok')),
                    );
                    return;
                  }
                  
                  // Password reset successful, navigate back to login
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kata sandi berhasil diubah')),
                  );
                  
                  // Navigate back to login page
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.donorLogin,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}