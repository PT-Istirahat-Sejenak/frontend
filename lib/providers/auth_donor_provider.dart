import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_donor_service.dart';
import '../models/user_role.dart';
import 'user_provider.dart';

class AuthDonorProvider extends ChangeNotifier {
  final _authService = AuthDonorService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      if (response['success']) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.setUser(
          role: UserRole.pendonor,
          token: response['token'],
          userJson: response['user'],
        );
        return true;
      } else {
        debugPrint('Login failed: ${response['message']}');
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

  // Register untuk semua role
  Future<bool> register({
    required String name,
    required String dateOfBirth,
    required String email,
    required String gender,
    required String address,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required UserRole role,
    File? profilePhoto,
    String? bloodType,
    String? rhesus,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.register(
        name: name,
        dateOfBirth: dateOfBirth,
        email: email,
        gender: gender,
        address: address,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
        profilePhoto: profilePhoto,
        bloodType: bloodType,
        rhesus: rhesus,
      );
      return response['success'];
    } catch (e) {
      debugPrint('Register error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
