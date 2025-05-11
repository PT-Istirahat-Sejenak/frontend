import 'package:donora_dev/services/seeker_form_service.dart';
import 'package:flutter/material.dart';

class SeekerFormProvider extends ChangeNotifier {
  final _seekerForm = SeekerFormService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> createSeeker({
    required int userId,
    required String bloodType,
    required String title,
    required String body,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _seekerForm.createSeeker(
        userId: userId,
        bloodType: bloodType,
        title: title,
        body: body,
      );

      return response['success'];
    } catch (e) {
      debugPrint('Error creating seeker: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}