import 'package:donora_dev/providers/user_provider.dart';
import 'package:donora_dev/screens/chat/chat_detail_screen.dart';
import 'package:donora_dev/screens/donor/donor_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../routes/app_routes.dart';
import 'upload_proof_donor_overlay.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../widgets/notification_card.dart';


class DonorHomeScreen extends StatefulWidget {
  const DonorHomeScreen({super.key});

  @override
  State<DonorHomeScreen> createState() => _DonorHomeScreenState();
}

class _DonorHomeScreenState extends State<DonorHomeScreen> {
  // Initialize Firebase Messaging
  late FirebaseMessaging _firebaseMessaging;
  late String _fcmMessage = '';
  late RemoteMessage messages;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging = FirebaseMessaging.instance;

    _firebaseMessaging.getToken().then((token) {
      // print("FCM Token: $token");
    });

    // Menangani pesan yang datang saat aplikasi terbuka
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final userIdString = message.data['user_id'];
      final userId = int.tryParse(userIdString ?? '');
      messages = message;
      print("Pesan diterima: ${message.notification?.title} | ${message.notification?.body}");

    // Memperbarui message dan menampilkan notifikasi
      setState(() {
        _fcmMessage = message.notification?.body ?? 'Tidak ada pesan';
      });
    });

    // Menangani pesan saat aplikasi di latar belakang atau tertutup
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message);
      print('Aplikasi dibuka dari notifikasi: ${message.notification?.title}');
    });
  }

  void _handleNotificationClick(RemoteMessage message) {
    final data = message.data;
    // final notifType = data['notif_type'];

    // if (notifType == 'chat') {
      final userId = int.tryParse(data['user_id'] ?? '');      

      final name = data['name'] ?? 'Pengguna';
      final imageUrl = data['profile_photo'];
      final isDonor = data['is_donor'] == 'true';

      if (userId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              name: name,
              imageUrl: imageUrl,
              isDonor: isDonor,
              userId: userId,
            ),
          ),
        );
      // }
    }
  }


  File? _selectedImage;
  bool _isUploading = false;

  void _handleImageSelected(File imageFile) {
    setState(() {
      _selectedImage = imageFile;
      //upload the image
      _simulateUpload();
    });
  }
  
  void _simulateUpload() {
    setState(() {
      _isUploading = true;
    });
    
    // Simulate upload delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isUploading = false;
          // Reset the image after successful "upload"
          _selectedImage = null;
          
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bukti donor berhasil diunggah!'),
              backgroundColor: Colors.green,
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final donor = Provider.of<UserProvider>(context).donor;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(context, donor),
                const SizedBox(height: 16),
                // Display the FCM message if available
                if (_fcmMessage.isNotEmpty)
                  NotificationCard(
                    title: "Notifikasi Baru",
                    message: _fcmMessage,
                    actionText: "Lihat detail",
                    icon: Icons.thumbs_up_down,
                    color: const Color(0xFFB00020),
                    textColor: Colors.white,
                    onActionPressed: () {          
                      _handleNotificationClick(messages);            
                      print('Notifikasi ditekan');                      
                    },
                  ),
                _buildDonationPrompt(context),
                const SizedBox(height: 20),
                _buildStatsSection(),
                const SizedBox(height: 24),
                _buildHistoryRewardSection(context),              
                const SizedBox(height: 24),
                _buildEducationSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, donor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side - Profile and name
        Row(
          children: [
            // Profile photo - circular with border
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                      image: (donor?.profilePhoto != null &&
                              donor!.profilePhoto!.isNotEmpty)
                          ? NetworkImage(donor.profilePhoto!)
                          : const AssetImage('assets/images/default_profile.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang!",
                  style: TextStyle(fontSize: 16, color: Color(0xFF5F5F5F)),
                ),
                Text(
                  donor?.name ?? 'Nama tidak ditemukan',
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        // Right side - Notification icon with navigation
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.donorNotification);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDonationPrompt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Konten dua kolom (teks dan gambar)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom teks
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sudah donor darah?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Yuk tukarkan reward",
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333), fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Unggah bukti donor darah Anda sekarang dan dapatkan 10 koin yang bisa ditukar dengan reward menarik!",
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Kolom gambar
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 12), // beri jarak atas dan bawah
                  child: Image.asset(
                    'assets/images/homeDonorImage.png',
                    height: 120, // kamu bisa atur ini ke 120 atau 140 kalau masih kecil
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Tombol ada di bawah dua kolom
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003C96),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isUploading
                  ? null
                  : () {
                      showUploadProofDonorOverlay(
                        context,
                        onImageSelected: _handleImageSelected,
                      );
                    },
              child: _isUploading
                  ? const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.upload_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Unggah Bukti Donor Darah",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Reorganized stats section with separate cards
  Widget _buildStatsSection() {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStatsCard("Total Donor", "1", Color(0xFFB00020)),
          const SizedBox(width: 12),
          _buildStatsCard("Donor\nTerakhir", "10 Jan\n2025", Color(0xFFB00020)),
          const SizedBox(width: 12),
          _buildStatsCard("Donor\nSelanjutnya", "10 Maret\n2025", Color(0xFFB00020)),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, Color color) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDBDB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryRewardSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildHistoryCard(context),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildRewardCard(),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.donorHistory),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.history, size: 24, color: Colors.black),
            ),
            const SizedBox(width: 12),
            const Text(
              "Riwayat Donor",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildRewardCard() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.donorReward),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.card_giftcard, size: 24, color: Colors.black),
            ),
            const SizedBox(width: 12),
            const Text(
              "Reward Saya",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Edukasi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DonorNav(initialIndex: 1),
                  ),
                );
              },
              child: const Row(
                children: [
                  Text(
                    "Selengkapnya",
                    style: TextStyle(color: Colors.black),
                    ),
                  Icon(Icons.chevron_right, size: 18, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildEducationCard(
          "21 April 2025",
          "3 Mitos tentang Donor Darah yang Masih Sering Dipercaya",
          "assets/images/edu1.png",
        ),
        const SizedBox(height: 12),
        _buildEducationCard(
          "21 April 2025",
          "7 Syarat Umum yang Harus Dipenuhi untuk Donor Darah",
          "assets/images/edu2.png",
        ),
      ],
    );
  }

  Widget _buildEducationCard(String date, String title, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}