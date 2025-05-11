// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SeekerFormService {
  final String baseUrl = 'https://gsc.fahrulhehehe.my.id/api/broadcast';

  Future<Map<String, dynamic>> createSeeker({
    required int userId,
    required String bloodType,
    required String title,
    required String body,
}) async {
    // final url = Uri.parse('$baseUrl/create');
    final response = await http.post(Uri.parse(baseUrl),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'blood_type': bloodType,
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
      };
    } else {
      return {
        'success': false,
        'message': jsonDecode(response.body)['error'] ?? 'Pencarian gagal',
      };
    }
  }
}