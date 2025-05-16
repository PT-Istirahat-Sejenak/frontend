import 'package:flutter/material.dart';
import '../../models/education_article.dart';
import '../../models/user_role.dart';

class EducationDetailScreen extends StatelessWidget {
  final UserRole userRole;
  final EducationArticle article;

  const EducationDetailScreen({
    super.key,
    required this.userRole,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image with padding
            Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset(
          article.imagePath,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Content items
                  ...article.content.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final MythFact item = entry.value;
                    return Column(
                      children: [
                        _buildContentItem(
                          number: index + 1,
                          myth: item.myth,
                          fact: item.fact,
                        ),
                        if (index != article.content.length - 1)
                          const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentItem({
    required int number,
    required String myth,
    required String fact,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Myth statement with number
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(text: '$number. '),
              TextSpan(text: myth),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // Fact explanation
        Text(
          fact,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}