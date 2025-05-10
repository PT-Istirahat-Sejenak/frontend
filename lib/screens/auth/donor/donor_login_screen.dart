// import 'package:donora_dev/screens/donor/donor_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_donor_provider.dart';
import '../../../providers/password_checkbox_provider.dart';

import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/forget_password_button.dart';
import '../../../widgets/remember_password_checkbox.dart';
import '../../../widgets/image_logo.dart';

import '../../../routes/app_routes.dart';
import '../../../core/constant.dart';

class DonorLoginScreen extends StatelessWidget {
  DonorLoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthDonorProvider>(context);
    final passwordCheckboxProvider = Provider.of<PasswordCheckboxProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo box
              const ImageLogo(), 
              const SizedBox(height: 10),

              // Title
              const Text(
                'DONORA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppText.fontFamily,
                  color: Color(0xFFAA0000),
                ),
              ),
              const SizedBox(height: 32),

              // Email field
              CustomTextField(
                label: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 16),

              // Password field with "Lupa kata sandi?"            
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                  label: "Kata Sandi",
                  controller: passwordController,
                  isPassword: true,
                  ),

                  const SizedBox(height: 9),
                  ForgetPasswordButton(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.donorForgetPassword);                    
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Checkbox "Ingatkan kata sandi"
              RememberPasswordCheckbox(
                value: passwordCheckboxProvider.ingatkan,
                onChanged: (value) {
                  passwordCheckboxProvider.toggleIngatkan(value);
                },
              ),
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: authProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    :PrimaryButton(
                      text: "MASUK",
                      onPressed: () async {
                        final email = emailController.text.trim();
                        final password = passwordController.text;
                        
                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Email dan password harus diisi")),
                          );
                          return;
                        }                        
                        
                        final isSuccess = await authProvider.login(email, password, context);

                        if (isSuccess) {
                          Navigator.pushReplacementNamed(context, AppRoutes.donorNav);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login gagal. Periksa kembali email dan password.")),
                          );
                        }
                      },
                    ),
              ),
              const SizedBox(height: 24),

              // Navigation to Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.donorRegister),
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Color(0xFFAA0000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
