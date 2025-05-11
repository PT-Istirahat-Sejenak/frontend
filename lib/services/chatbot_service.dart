import 'dart:convert';
// import 'dart:ffi';

import 'package:http/http.dart' as http;

class ChatbotService {
  final String baseUrl = 'https://gsc.fahrulhehehe.my.id/api/chatbot';

  Future<Map<String, dynamic>> sendMessage({
    required int userId,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'message': message,
      }),
    );

    print(response.body + ' responnya kayak gini');

    if (response.statusCode == 200) {
      return {
        'success': true,
        'response': jsonDecode(response.body),
      };
    } else {
      return {
        'success': false,
        'message': jsonDecode(response.body)['error'] ?? 'Error sending message',
      };
    }
  }
}