class Course {
  final String id;
  final String title;
  final String instructorName;
  final String thumbnailUrl;
  final double rating;
  final int studentsCount;
  final String country;
  final String grade;
  final String subject;
  final bool isLive;

  Course({
    required this.id,
    required this.title,
    required this.instructorName,
    required this.thumbnailUrl,
    required this.rating,
    required this.studentsCount,
    required this.country,
    required this.grade,
    required this.subject,
    this.isLive = false,
  });
}

class CourseCategory {
  final String name;
  final String icon;

  CourseCategory({required this.name, required this.icon});
}
