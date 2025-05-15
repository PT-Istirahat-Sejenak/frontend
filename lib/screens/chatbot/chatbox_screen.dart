import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/chatbot_service.dart';
import '../../providers/user_provider.dart';

class ChatboxScreen extends StatefulWidget {
  const ChatboxScreen({super.key});

  @override
  State<ChatboxScreen> createState() => _ChatboxScreenState();
}

class _ChatboxScreenState extends State<ChatboxScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      isBot: true,
      message: "Hai! Saya chatbot Edukasi Donor Darah. Ada yang bisa saya bantu?",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  final ChatbotService _chatbotService = ChatbotService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 24, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Chatbox',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(30),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageItem(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (message.isBot) ...[
            _buildBotAvatar(),
            const SizedBox(width: 8),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: message.isBot ? Colors.white : const Color(0xFFFFC1C1),
                borderRadius: BorderRadius.only(
                  topLeft: message.isBot ? Radius.circular(0) : Radius.circular(16),
                  topRight: message.isBot ? Radius.circular(16) : Radius.circular(0),
                  bottomLeft: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                ),
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          if (!message.isBot) const SizedBox(width: 5),
        ],
      ),
    );
  }


  Widget _buildBotAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/picture_chatbot.png',
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
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
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.black87,
                      size: 24,
                    ),
                    onPressed: () async {
                      final userMessage = _messageController.text.trim();
                      if (userMessage.isEmpty) return;

                      setState(() {
                        _messages.add(ChatMessage(
                          isBot: false,
                          message: userMessage,
                          timestamp: DateTime.now(),
                        ));
                        _messageController.clear();
                      });

                      try {
                        final userProvider = Provider.of<UserProvider>(context, listen: false);
                        final userIdStr = userProvider.userId ?? '0';
                        final userId = int.tryParse(userIdStr) ?? 0;

                        final response = await _chatbotService.sendMessage(
                          message: userMessage,
                          userId: userId,
                        );

                        final botReply = response['success']
                            ? response['response']['reply'] ?? 'Bot tidak merespons.'
                            : 'Error: ${response['message']}';

                        setState(() {
                          _messages.add(ChatMessage(
                            isBot: true,
                            message: botReply,
                            timestamp: DateTime.now(),
                          ));
                        });
                      } catch (e) {
                        setState(() {
                          _messages.add(ChatMessage(
                            isBot: true,
                            message: 'Gagal mengirim pesan. Coba lagi.',
                            timestamp: DateTime.now(),
                          ));
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final bool isBot;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.isBot,
    required this.message,
    required this.timestamp,
  });
}
