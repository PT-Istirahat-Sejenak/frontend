import 'dart:async';

import 'package:flutter/material.dart';
import '../../utils/auth_utils.dart';
import '../../routes/app_routes.dart';
import '../../core/constant.dart';
import '../../widgets/image_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Cek apakah user sudah login
      final isLoggedIn = AuthUtils.isLoggedIn(context);

      if (isLoggedIn) {
        // Jika login, redirect ke dashboard sesuai role
        AuthUtils.redirectToDashboard(context);
      } else {
        // Jika belum login, arahkan ke onboarding
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
            children: [
            const ImageLogo(),
            const SizedBox(width: 12),
            const Text(
              'DONORA',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontFamily: AppText.fontFamily,
                fontWeight: FontWeight.w700,
                color: AppText.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}