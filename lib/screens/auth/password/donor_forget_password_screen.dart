import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../password/donor_verification_code_screen.dart';

class DonorForgotPasswordScreen extends StatefulWidget {
  const DonorForgotPasswordScreen({super.key});

  @override
  State<DonorForgotPasswordScreen> createState() => _DonorForgotPasswordScreenState();
}

class _DonorForgotPasswordScreenState extends State<DonorForgotPasswordScreen> {
  final TextEditingController _donorEmailController = TextEditingController();

  @override
  void dispose() {
    _donorEmailController.dispose();
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
                      Navigator.pushReplacementNamed(context, AppRoutes.donorLogin);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Lupa Kata Sandi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 25),
              
              // Description text
              Text(
                'Kami akan mengirimkan 6 digit kode ke email berikut ini',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 25),
              
              // Email input field using CustomTextField
              CustomTextField(
                label: 'Email',
                controller: _donorEmailController,
              ),
              
              const SizedBox(height: 25),
              
              // Continue button
              PrimaryButton(
                text: 'LANJUT',
                onPressed: () {
                  if (_donorEmailController.text.isNotEmpty) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.donorVerificationCode,
                      arguments: DonorVerificationCodeScreen(donorEmail: _donorEmailController.text),
                    );
                  } else {
                    // Show snackbar or validation message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Masukkan alamat email')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}