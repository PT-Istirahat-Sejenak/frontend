import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/primary_button.dart';

class SeekerVerificationCodeScreen extends StatefulWidget {
  final String seekerEmail;
  
  const SeekerVerificationCodeScreen({
    super.key, 
    required this.seekerEmail,
  });

  @override
  State<SeekerVerificationCodeScreen> createState() => _SeekerVerificationCodeScreenState();
}

class _SeekerVerificationCodeScreenState extends State<SeekerVerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6, 
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6, 
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
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
                      Navigator.pushReplacementNamed(context, AppRoutes.seekerForgetPassword);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Kode Verifikasi',
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
                'Masukkan kode verifikasi yang telah dikirim ke email Anda',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 25),
              
              // Verification code input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    height: 40,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 25),
              
              // Submit button
              PrimaryButton(
                text: 'KIRIM',
                onPressed: () {
                  // Validate the verification code
                  final code = _controllers.map((c) => c.text).join();
                  if (code.length == 6) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.seekerNewPassword,
                    );
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Masukkan kode verifikasi lengkap')),
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