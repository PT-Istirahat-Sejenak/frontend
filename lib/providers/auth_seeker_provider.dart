import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_seeker_service.dart';
import '../models/user_role.dart';
import 'user_provider.dart';

class AuthSeekerProvider extends ChangeNotifier {
  final _authService = AuthSeekerService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await _authService.login(email, password);

      if (res['success']) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.setUser(
          email: email,
          role: UserRole.seeker,
          token: res['token'],
        );
        return true;
      } else {
        debugPrint('Login failed: ${res['message']}');
        return false;
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String name,
    required String dateOfBirth,
    required String email,
    required String gender,
    required String address,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await _authService.register(
        name: name,
        dateOfBirth: dateOfBirth,
        email: email,
        gender: gender,
        address: address,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
      );

      return res['success'];
    } catch (e) {
      debugPrint('Register error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
