import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_role.dart';
import '../providers/user_provider.dart';
import '../routes/app_routes.dart';

class AuthUtils {
  /// Redirect user ke halaman dashboard sesuai role
  static void redirectToDashboard(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.role == UserRole.pendonor) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.donorNav,
      );
    } else if (userProvider.role == UserRole.pencari) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.seekerNav,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.selectRole,
      );
    }
  }

  /// Logout user dan arahkan ke role selection
  static Future<void> logout(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).logout();
    Navigator.pushAndRemoveUntil(
      context,
      AppRoutes.selectRole as Route<Object?>,
      (route) => false,
    );
  }

  /// Return true jika user sedang login
  static bool isLoggedIn(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return userProvider.isLoggedIn;
  }

  /// Dapatkan role user aktif
  static UserRole? getUserRole(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false).role;
  }
}
