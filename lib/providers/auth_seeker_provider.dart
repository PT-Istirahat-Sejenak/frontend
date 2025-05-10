import 'dart:io';
import 'package:donora_dev/services/auth_seeker_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_role.dart';
import 'user_provider.dart';

class AuthSeekerProvider extends ChangeNotifier {
  final _authService = AuthSeekerService();

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
          role: UserRole.pencari,
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
