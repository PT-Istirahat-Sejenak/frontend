class OnboardingContent {
  final String title;
  final String description;
  final String image;
  final String buttonText;
  final bool isLastPage;

  OnboardingContent({
    required this.title, 
    required this.description, 
    required this.image,
    this.buttonText = 'L A N J U T',
    this.isLastPage = false,
  });
}