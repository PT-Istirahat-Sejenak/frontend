import 'package:donora_dev/providers/user_provider.dart';
import 'package:donora_dev/screens/seeker/seeker_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';

class SeekerHomeScreen extends StatefulWidget {
  const SeekerHomeScreen({super.key});

  @override
  State<SeekerHomeScreen> createState() => _SeekerHomeScreenState();
}

class _SeekerHomeScreenState extends State<SeekerHomeScreen> {
  // Added a boolean to track if there's an active search
  bool isSearchInProgress = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if there's route arguments for search status
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      if (args.containsKey('isSearching')) {
        setState(() {
          isSearchInProgress = args['isSearching'] ?? false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final seeker = Provider.of<UserProvider>(context).seeker;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(context, seeker),
                const SizedBox(height: 16),
                // Only show search progress section if a search is in progress
                if (isSearchInProgress) _buildSearchProgressSection(context),
                if (!isSearchInProgress) _buildDonationPrompt(context),              
                const SizedBox(height: 24),
                _buildEducationSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, seeker) {
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
                      image: (seeker?.profilePhoto != null &&
                              seeker!.profilePhoto!.isNotEmpty)
                          ? NetworkImage(seeker.profilePhoto!)
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
                  seeker?.name ?? 'Nama tidak ditemukan',
                  style: TextStyle(
                    fontSize: 14,
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
            Navigator.pushNamed(context, AppRoutes.seekerNotification);
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

  // New widget for search progress section
  Widget _buildSearchProgressSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: Colors.blue[700], size: 22),
              const SizedBox(width: 10),
              Text(
                "Sedang mencari pendonor darah...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: null, // Indeterminate progress
            backgroundColor: Colors.blue[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[100]!),
            ),
            child: const Text(
              "Kami sedang mencocokkan kriteria Anda.",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red[700]!),
                foregroundColor: Colors.red[700],
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Cancel the search
                setState(() {
                  isSearchInProgress = false;
                });
              },
              child: const Text(
                "Batalkan Pencarian",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Butuh donor darah segera?",
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Cari pendonor terdekat dengan cepat.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Klik tombol di bawah ini untuk mulai mencari pendonor sekarang juga!",
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                    ),
                  ],
                ),
              ),
              
              // Right side - image
              Image.asset(
                'assets/images/homeSeekerImage.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Full-width search button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB91C1C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed:() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SeekerNav(initialIndex: 2),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/search-icon.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Cari Pendonor Sekarang",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Text(
                    "Selengkapnya",
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.chevron_right, size: 18, color: Colors.black,),
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