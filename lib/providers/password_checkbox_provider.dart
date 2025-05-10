import 'package:flutter/material.dart';

class PasswordCheckboxProvider extends ChangeNotifier {
  bool _ingatkan = false;

  bool get ingatkan => _ingatkan;

  void toggleIngatkan(bool? value) {
    _ingatkan = value ?? false;
    notifyListeners();
  }
}
