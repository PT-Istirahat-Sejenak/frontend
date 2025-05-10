import 'package:flutter/material.dart';
import '../../models/user_role.dart';
import '../../models/education_article.dart';
import '../../routes/app_routes.dart';

import '../chatbot/chatbox_screen.dart';

class EducationScreen extends StatefulWidget {
  final UserRole userRole;

  const EducationScreen({
    super.key,
    required this.userRole,
  });

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _selectedFilter = 'Edukasi';

  // Sample education articles - in a real app, you'd fetch these from a service
  final List<EducationArticle> _articles = [
    EducationArticle(
      id: '1',
      title: '3 Mitos tentang Donor Darah yang Masih Sering Dipercaya',
      date: '21 April 2025',
      imagePath: 'assets/images/blood_donor_myth.jpg',
      content: [
        MythFact(
          myth: 'Donor darah menyebabkan tubuh lemas.',
          fact: 'Fakta: Donor darah tidak membuat tubuh lemas. Setelah donor, tubuh akan segera memproduksi darah baru untuk menggantikan yang hilang.',
        ),
        MythFact(
          myth: 'Donor darah menyakitkan',
          fact: 'Fakta: Proses donor darah hanya melibatkan sedikit rasa sakit saat jarum dimasukkan mirip dengan sensasi dicubit ringan.',
        ),
        MythFact(
          myth: 'Orang bertato tidak bisa donor darah',
          fact: 'Fakta: Orang bertato dapat menjadi donor darah, asalkan tato tersebut telah dibuat lebih dari 12 bulan sebelumnya dan memenuhi syarat kesehatan lainnya.',
        ),
      ],
    ),
    EducationArticle(
      id: '2',
      title: '7 Syarat Umum yang Harus Dipenuhi Sebelum Donor Darah',
      date: '21 April 2025',
      imagePath: 'assets/images/blood_donor_requirements.jpg',
      content: [], // Add actual content here
    ),
    EducationArticle(
      id: '3',
      title: 'Dampak Positif dan Negatif Donor Darah bagi Kesehatan',
      date: '21 April 2025',
      imagePath: 'assets/images/blood_donor_effects.jpg',
      content: [], // Add actual content here
    ),
      EducationArticle(
      id: '3',
      title: 'Dampak Positif dan Negatif Donor Darah bagi Kesehatan',
      date: '21 April 2025',
      imagePath: 'assets/images/blood_donor_effects.jpg',
      content: [], // Add actual content here
    ),
      EducationArticle(
      id: '3',
      title: 'Dampak Positif dan Negatif Donor Darah bagi Kesehatan',
      date: '21 April 2025',
      imagePath: 'assets/images/blood_donor_effects.jpg',
      content: [], // Add actual content here
    ),
      EducationArticle(
      id: '3',
      title: 'Dampak Positif dan Negatif Donor Darah bagi Kesehatan',
      date: '21 April 2025',
      imagePath: 'assets/images/blood_donor_effects.jpg',
      content: [], // Add actual content here
    ),
      EducationArticle(
      id: '4',
      title: 'Dampak Positif dan Negatif Donor Darah bagi Kesehatan',
      date: '21 April 2025',
      imagePath: 'assets/images/blood_donor_effects.jpg',
      content: [], // Add actual content here
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 20, 12),
                  child: Text(
                    'Edukasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _buildFilterSection(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Bagian yang bisa di-scroll
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                final article = _articles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildEducationCard(
                    article: article,
                    onTap: () => _navigateToDetail(article),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatboxScreen()),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white, // White background matching page color
                shape: OvalBorder(
                  side: BorderSide(
                    width: 2,
                    color: Color(0xFFAAAAAA), // Lighter gray border
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Image.asset(
                    'assets/icons/picture_chatbot.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Chatbot',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('Edukasi'),
          const SizedBox(width: 10),
          _buildFilterChip('Prosedur'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCard({
    required EducationArticle article,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
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
                  image: AssetImage(article.imagePath),
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
                    article.date,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(EducationArticle article) {
    if (widget.userRole == UserRole.patient) {
      Navigator.pushNamed(
        context, 
        AppRoutes.donorEducationDetail,
        arguments: article,
      );
    } else {
      // Assuming you'll create a seeker education route in the future
      Navigator.pushNamed(
        context, 
        AppRoutes.seekerEducationDetail,  
        arguments: article,
      );
    }
  }
}