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

  //Provider for donor login
  Future<bool> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(email, password);

      if (response['success']) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.setUser(
          email: email,
          role: UserRole.patient,
          token: response['token'],
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

  //Provider for donor registration
  Future<bool> register({
    required String name,
    required String dateOfBirth,
    required String email,
    required String gender,
    required String address,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String bloodType,
    required String rhesus,
    File? profileImage,

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
        bloodType: bloodType,
        rhesus: rhesus,
        profileImage: profileImage,
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
