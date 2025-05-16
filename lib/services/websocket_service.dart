import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  late WebSocketChannel _channel;

  void connect(int userId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://gsc.fahrulhehehe.my.id/api/message'),
    );

    // Kirim user_id
    _channel.sink.add(jsonEncode({"user_id": userId}));

    // Listen pesan masuk
    _channel.stream.listen((message) {
      print("📨 Dapet pesan: $message");
      // TODO: update global state / notifikasi dsb
    });
  }

  void sendMessage(int senderId, int receiverId, String message) {
    final data = {
      "sender_id": senderId,
      "receiver_id": receiverId,
      "message": message,
    };
    _channel.sink.add(jsonEncode(data));
  }

  void close() {
    _channel.sink.close();
  }
}