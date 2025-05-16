import 'dart:convert';
import 'dart:io';
import 'package:donora_dev/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class AuthSeekerService {
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
        'role': 'pencari',
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

  if (profilePhoto != null) {
    debugPrint("File path: ${profilePhoto.path}");
    final mimeType = lookupMimeType(profilePhoto.path);
    debugPrint("MIME Type: $mimeType");
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
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return {
        'success': true,
        'token': data['token'],
        'user': data['user'],
      };
    } else {
      debugPrint('Register errorr : ${response.body}');
      return {
        'success': false,
        'message': jsonDecode(response.body)['message'] ?? 'Register gagal',
      };
    }
  }
}
