import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/user_role.dart';
import '../../providers/user_provider.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool isDonor;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isDonor,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  // Helper method to try loading an image with a fallback
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
    
    // Print the widget values to debug
    print("Chat detail screen initialized:");
    print("Name: ${widget.name}");
    print("Image URL: ${widget.imageUrl}");
    print("Is Donor: ${widget.isDonor}");
    
    // Initialize date formatting for Indonesian locale
    initializeDateFormatting('id_ID', '').then((_) {
      // Load mock messages after locale is initialized
      _loadMessages();
    });
  }

  void _loadMessages() {
    // Sample chat messages specific to the screen shown in your second image
    final date = DateTime(2025, 4, 7); // April 7, 2025 to match the screenshot
    
    // Add a debug print to verify messages are being added
    print("Loading mock messages...");
    
    setState(() {
      _messages.addAll([
        ChatMessage(
          message: 'Halo, saya bersedia donor darah A+',
          time: '08:45',
          isFromDonor: true,
          timestamp: date,
        ),
        ChatMessage(
          message: 'Terima kasih banyak kak, butuh di Sardjito',
          time: '08:45',
          isFromDonor: false,
          timestamp: date,
        ),
        ChatMessage(
          message: 'Oke, kapan dibutuhkannya kak?',
          time: '08:45',
          isFromDonor: true,
          timestamp: date,
        ),
        ChatMessage(
          message: 'Kalau bisa hari ini kak',
          time: '08:45',
          isFromDonor: false,
          timestamp: date,
        ),
        ChatMessage(
          message: 'Oke, saya ke sana sore ini, ya.',
          time: '08:45',
          isFromDonor: true,
          timestamp: date,
        ),
        ChatMessage(
          message: 'Siap, terima kasih banyak kak.',
          time: '08:45',
          isFromDonor: false,
          timestamp: date,
        ),
      ]);
      
      // Add a debug print to verify messages count
      print("Loaded ${_messages.length} messages");
    });

    // Scroll to the bottom after messages are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
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
    final isUserDonor = userProvider.role == UserRole.patient;
    
    // If widget.isDonor is true, then the chat partner is a donor
    // The message is FROM donor if the user is a donor
    final isFromDonor = isUserDonor;
    
    setState(() {
      _messages.add(
        ChatMessage(
          message: _messageController.text.trim(),
          time: DateFormat('HH:mm').format(DateTime.now()), // Simpler format that doesn't require locale
          isFromDonor: isFromDonor,
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
    });
    
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isUserDonor = userProvider.role == UserRole.patient;
    
    // Debug print current state
    print("Building chat detail screen with ${_messages.length} messages");
    print("Current user is ${isUserDonor ? 'donor' : 'seeker'}");

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Use CircleAvatar with initials as fallback if image not available
            CircleAvatar(
              backgroundColor: Colors.purple.shade100,
              child: Text(
                widget.name.isNotEmpty ? widget.name[0] : "?",
                style: const TextStyle(color: Colors.black),
              ),
              radius: 16,
              // We'll try to use the image if it exists, but have a fallback
              backgroundImage: _tryLoadImage(widget.imageUrl),
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Add a direct debug text to see if the body is rendering
          if (_messages.isEmpty)
            const Expanded(
              child: Center(
                child: Text("No messages to display"),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final bool isFromCurrentUser = isUserDonor == message.isFromDonor;
                  
                  // Show donor bubble (red) if message is from donor
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
                            ? const Color(0xFFD32F2F) // Red for donor
                            : const Color(0xFFFFC1C1), // Pink for seeker
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
                },
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
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
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ketikkan pesan',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.grey),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String message;
  final String time;
  final bool isFromDonor; // True if the message is from a donor, false if from a seeker
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.time,
    required this.isFromDonor,
    required this.timestamp,
  });
}