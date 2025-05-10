class EducationArticle {
  final String id;
  final String title;
  final String date;
  final String imagePath;
  final List<MythFact> content;

  EducationArticle({
    required this.id,
    required this.title,
    required this.date,
    required this.imagePath,
    required this.content,
  });
}

class MythFact {
  final String myth;
  final String fact;

  MythFact({
    required this.myth,
    required this.fact,
  });
}