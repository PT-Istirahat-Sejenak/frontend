import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../password/seeker_verification_code_screen.dart';

class SeekerForgotPasswordScreen extends StatefulWidget {
  const SeekerForgotPasswordScreen({super.key});

  @override
  State<SeekerForgotPasswordScreen> createState() => _SeekerForgotPasswordScreenState();
}

class _SeekerForgotPasswordScreenState extends State<SeekerForgotPasswordScreen> {
  final TextEditingController _seekerEmailController = TextEditingController();

  @override
  void dispose() {
    _seekerEmailController.dispose();
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
                      Navigator.pushReplacementNamed(context, AppRoutes.seekerLogin);
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
                controller: _seekerEmailController,
              ),
              
              const SizedBox(height: 25),
              
              // Continue button
              PrimaryButton(
                text: 'LANJUT',
                onPressed: () {
                  if (_seekerEmailController.text.isNotEmpty) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.seekerVerificationCode,
                      arguments: SeekerVerificationCodeScreen(seekerEmail: _seekerEmailController.text),
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