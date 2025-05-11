import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_role.dart';
import '../models/donor_user_model.dart';
import '../models/seeker_user_model.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier {
  String? _token;
  UserRole? _role;
  bool _isLoggedIn = false;
  DonorUserModel? _donor;
  SeekerUserModel? _seeker;

  String? get userId {
    if (_role == UserRole.pendonor) {
      return _donor?.id.toString();
    } else if (_role == UserRole.pencari) {
      return _seeker?.id.toString();
    }
    return null;
  }

  String? get token => _token;
  UserRole? get role => _role;
  bool get isLoggedIn => _isLoggedIn;
  DonorUserModel? get donor => _donor;
  SeekerUserModel? get seeker => _seeker;

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _role = UserRoleExt.fromString(prefs.getString('role'));
    _isLoggedIn = _token != null;

    final userData = prefs.getString('user_data');
    if (userData != null) {
      final decoded = jsonDecode(userData);
      if (_role == UserRole.pendonor) {
        _donor = DonorUserModel.fromJson(decoded);
      } else if (_role == UserRole.pencari) {
        _seeker = SeekerUserModel.fromJson(decoded);
      }
    }

    notifyListeners();
  }

  Future<void> setUser({
    required UserRole role,
    required String token,
    required Map<String, dynamic> userJson,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role.toJson());
    await prefs.setString('token', token);
    await prefs.setString('user_data', jsonEncode(userJson));

    _role = role;
    _token = token;
    _isLoggedIn = true;

    if (role == UserRole.pendonor) {
      _donor = DonorUserModel.fromJson(userJson);
    } else if (role == UserRole.pencari) {
      _seeker = SeekerUserModel.fromJson(userJson);
    }

    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // optional: clear all, or just remove specific keys

    _token = null;
    _role = null;
    _donor = null;
    _seeker = null;
    _isLoggedIn = false;

    notifyListeners();
  }
}
