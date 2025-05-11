import 'dart:convert';
import 'dart:io';
import 'package:donora_dev/providers/auth_donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/user_role.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class AuthDonorService {
  final String baseUrl = 'https://gsc.fahrulhehehe.my.id/api/auth';

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': 'pendonor',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'success': true,
        'token': data['token'],
        'user': data['user'],
      };
    } else {
      return {
        'success': false,
        'message': jsonDecode(response.body)['message'] ?? 'Login gagal',
      };
    }
  }

Future<Map<String, dynamic>> register({
  required String name,
  required String dateOfBirth,
  required String email,
  required String gender,
  required String address,
  required String phoneNumber,
  required String password,
  required String confirmPassword,
  required UserRole role,
  required String fcmToken,
  File? profilePhoto,
  String? bloodType,
  String? rhesus,
}) async {
  final url = Uri.parse('$baseUrl/register');

  final request = http.MultipartRequest('POST', url)
    ..fields['name'] = name
    ..fields['date_of_birth'] = dateOfBirth
    ..fields['email'] = email
    ..fields['gender'] = gender
    ..fields['address'] = address
    ..fields['phone_number'] = phoneNumber
    ..fields['password'] = password
    ..fields['password_confirmation'] = confirmPassword
    ..fields['role'] = role.toJson()
    ..fields['fcm_token'] = fcmToken;


  if (role == UserRole.pendonor) {
    request.fields['blood_type'] = bloodType ?? '';
    request.fields['rhesus'] = rhesus ?? '';
  }

  if (profilePhoto != null) {
    final mimeType = lookupMimeType(profilePhoto.path);
    if (mimeType != null && mimeType.startsWith('image/')) {
      final file = await http.MultipartFile.fromPath(
        'profile_photo',
        profilePhoto.path,
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(file);
    } else {
      throw Exception('File harus berupa gambar (JPEG, PNG, GIF)');
    }
  }

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  print(fcmToken + ' token di service ya');
  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = jsonDecode(response.body);
    final user = data['user'];
    final token = data['token'];

    return {
      'success': true,
      'token': token,
      'user': user,
    };
  } else {
    debugPrint('Register error: ${response.body}');
    return {
      'success': false,
      'message': jsonDecode(response.body)['message'] ?? 'Register gagal',
    };
  }
}
}
