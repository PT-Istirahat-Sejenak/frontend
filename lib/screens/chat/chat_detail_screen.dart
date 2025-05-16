import 'package:donora_dev/services/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/user_role.dart';
import '../../providers/user_provider.dart';

import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String? imageUrl;
  final bool isDonor;
  final int userId;

  const ChatDetailScreen({
    super.key,
    required this.name,
    this.imageUrl,
    required this.isDonor,
    required this.userId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late WebSocketChannel _channel;
  final String _wsUrl = 'wss://gsc.fahrulhehehe.my.id/api/message';

  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  ImageProvider? _tryLoadImage(String imageUrl) {
    try {
      return AssetImage(imageUrl);
    } catch (e) {
      print("Failed to load image: $imageUrl");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('id_ID', '').then((_) {
      _loadMessages();
      _channel = IOWebSocketChannel.connect(Uri.parse(_wsUrl));

      _channel.stream.listen((data) {
        final decoded = json.decode(data);
        final newMessage = ChatMessage(
          message: decoded['content'],
          time: DateFormat('HH:mm').format(DateTime.parse(decoded['created_at'])),
          isFromDonor: decoded['sender_id'] == Provider.of<UserProvider>(context, listen: false).userId,
          timestamp: DateTime.parse(decoded['created_at']),
        );

        setState(() {
          _messages.add(newMessage);
        });

        _scrollToBottom();
      });
    });
  }

  void _loadMessages() {

  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final now = DateTime.now();

    // Kirim lewat WebSocketService
    WebSocketService().sendMessage(
      userProvider.userId! as int,
      widget.userId, // ini adalah receiver_id dari argumen ChatDetailScreen
      _messageController.text.trim(),
    );

    setState(() {
      _messages.add(
        ChatMessage(
          message: _messageController.text.trim(),
          time: DateFormat('HH:mm').format(now),
          isFromDonor: userProvider.role == UserRole.pendonor,
          timestamp: now,
        ),
      );
      _messageController.clear();
    });

    _scrollToBottom();
  }



  Widget _buildMessageItem(ChatMessage message, bool isFromCurrentUser) {
    final bool showDonorBubble = message.isFromDonor;
    return Align(
      alignment: isFromCurrentUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: showDonorBubble
              ? const Color(0xFFD32F2F) // Merah pendonor
              : const Color(0xFFFFC1C1), // Pink pencari
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: showDonorBubble ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(
                color: showDonorBubble ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Ketikkan pesan',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.black87,
                      size: 24,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isUserDonor = userProvider.role == UserRole.pendonor;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Text(
                widget.name.isNotEmpty ? widget.name[0] : "?",
                style: const TextStyle(color: Colors.black),
              ),
              radius: 16,
              backgroundImage: widget.imageUrl != null ? _tryLoadImage(widget.imageUrl!) : null,
            ),
            const SizedBox(width: 10),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _messages.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text("No messages to display"),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isFromCurrentUser =
                          isUserDonor == message.isFromDonor;
                      return _buildMessageItem(message, isFromCurrentUser);
                    },
                  ),
                ),
          _buildMessageInput(),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String message;
  final String time;
  final bool isFromDonor;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.time,
    required this.isFromDonor,
    required this.timestamp,
  });
}
