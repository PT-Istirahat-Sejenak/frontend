import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_role.dart';

class UserProvider with ChangeNotifier {
  String? _email;
  String? _token;
  UserRole? _role;
  bool _isLoggedIn = false;

  String? get email => _email;
  String? get token => _token;
  UserRole? get role => _role;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _email = prefs.getString('email');
    _role = UserRoleExt.fromString(prefs.getString('role'));
    _isLoggedIn = _token != null;
    notifyListeners();
  }

  Future<void> setUser({
    required String email,
    required UserRole role,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('role', role.toJson());
    await prefs.setString('token', token);

    _email = email;
    _role = role;
    _token = token;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('email');
    await prefs.remove('role');

    _token = null;
    _email = null;
    _role = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
