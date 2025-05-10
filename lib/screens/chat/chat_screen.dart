import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_detail_screen.dart';
import '../../models/user_role.dart';
import '../../providers/user_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We'll use the user provider to check the current user's role
    final userProvider = Provider.of<UserProvider>(context);
    final isSeeker = userProvider.role == UserRole.pencari;

    // Mock data for chat list - in a real app, fetch this from your database
    final List<Map<String, dynamic>> chatList = [
      {
        'name': 'Muhammad Najwan',
        'message': 'Halo, saya bersedia donor untuk...',
        'time': '08:45 PM',
        'imageUrl': 'assets/images/onboarding_1.png',
        'isDonor': true,
      },
      {
        'name': 'Nana',
        'message': 'Halo, saya bersedia donor untuk...',
        'time': '08:45 PM',
        'imageUrl': 'assets/images/onboarding_2.png',
        'isDonor': true,
      },
      {
        'name': 'Marcella',
        'message': 'Halo, saya bersedia donor untuk...',
        'time': '08:45 PM',
        'imageUrl': 'assets/images/onboarding_3.png',
        'isDonor': true,
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pesan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
          ),
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
        final chat = chatList[index];
        return ListTile(
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              name: chat['name'],
              imageUrl: chat['imageUrl'],
              isDonor: chat['isDonor'],
            ),
            ),
          );
          },
          leading: CircleAvatar(
          backgroundImage: AssetImage(chat['imageUrl']),
          radius: 20,
          ),
          title: Text(
          chat['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
          chat['message'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
          chat['time'],
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
        },
      ),
      ),
      backgroundColor: Colors.white,
    );
  }
}