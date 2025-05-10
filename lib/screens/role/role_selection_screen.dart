import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import '../../widgets/back_button.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

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
              // Back button
              BackButtonWidget(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
                },
              ),
              
              // Spacing to push content to the center
              const Spacer(flex: 2),
              
              // Title
              const Center(
                child: Text(
                  'Pilih peran',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Pendonor Button
              PrimaryButton(
                text: 'PENDONOR',
                width: 260,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.donorLogin);
                },
              ),
              
              const SizedBox(height: 8),
              
              // Description for Pendonor
              const Center(
                child: Text(
                  'Bantu sesama dengan donor darah',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Pencari Donor Button
              SecondaryButton(
                text: 'PENCARI DONOR',
                width: 260,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.seekerLogin);
                },
              ),
              
              const SizedBox(height: 8),
              
              // Description for Pencari Donor
              const Center(
                child: Text(
                  'Cari bantuan donor secara cepat',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              
              // Spacing to push content to center
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}