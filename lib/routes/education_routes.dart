import 'package:flutter/material.dart';
import '../models/user_role.dart';
import '../models/education_article.dart';
import '../screens/education/education_screen.dart';
import '../screens/education/education_detail_screen.dart';
import 'app_routes.dart';

class EducationRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings, UserRole role) {
    // Get arguments yang dikirim
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.donorEducation:
      case AppRoutes.seekerEducation:
        return MaterialPageRoute(
          builder: (_) => EducationScreen(userRole: role),
        );

      case AppRoutes.donorEducationDetail:
      case AppRoutes.seekerEducationDetail:
        // Pastikan arguments adalah EducationArticle
        if (args is! EducationArticle) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Invalid article data')),
            ),
          );
        }
        
        return MaterialPageRoute(
          builder: (_) => EducationDetailScreen(
            article: args,
            userRole: role,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Education route not found')),
          ),
        );
    }
  }
}