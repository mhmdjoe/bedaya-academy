class Instructor {
  final String id;
  final String name;
  final String expertise;
  final String bio;
  final String photoUrl;
  final double rating;
  final int experienceYears;
  final List<String> subjects;
  final double sessionPrice;

  Instructor({
    required this.id,
    required this.name,
    required this.expertise,
    required this.bio,
    required this.photoUrl,
    required this.rating,
    required this.experienceYears,
    required this.subjects,
    this.sessionPrice = 0,
  });
}
