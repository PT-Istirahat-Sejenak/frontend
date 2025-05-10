import 'package:flutter/material.dart';
import 'onboarding_content.dart';
import '../../routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> contents = [
    OnboardingContent(
      title: 'Ayo Donor Darah',
      description: 'Donorkan darah Anda untuk Sesama',
      image: 'assets/images/onboarding_1.png',
    ),
    OnboardingContent(
      title: 'Menjadi Pendonor',
      description: 'Dapatkan kemudahan untuk menjadi pendonor darah',
      image: 'assets/images/onboarding_2.png',
    ),
    OnboardingContent(
      title: 'Cari Pendonor',
      description: 'Temukan pendonor darah dengan lebih cepat dan mudah',
      image: 'assets/images/onboarding_3.png',
      buttonText: 'M U L A I',
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: contents.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.08,
                  vertical: size.height * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      contents[index].image,
                      height: size.height * 0.3,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Text(
                      contents[index].title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      contents[index].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (i) => buildDot(i),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: size.width * 0.08,
            right: size.width * 0.08,
            bottom: size.height * 0.08,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == contents.length - 1) {
                  Navigator.pushReplacementNamed(
                    context, AppRoutes.selectRole,
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAA0000),
                minimumSize: Size(double.infinity, size.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                contents[_currentPage].buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      height: 5,
      width: 18,
      margin: const EdgeInsets.only(right: 5),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFBDBABA),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        color: _currentPage == index
            ? const Color(0xFFAA0000)
            : const Color(0xFFEEEEEE),
      ),
    );
  }
}
