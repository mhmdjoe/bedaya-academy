import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/course_repository.dart';
import '../../domain/models/course.dart';

final courseRepositoryProvider = Provider((ref) => CourseRepository());

final selectedCountryProvider = StateProvider<String?>((ref) => null);
final selectedGradeProvider = StateProvider<String?>((ref) => null);
final selectedSubjectProvider = StateProvider<String?>((ref) => null);

final filteredCoursesProvider = Provider<List<Course>>((ref) {
  final repository = ref.watch(courseRepositoryProvider);
  final courses = repository.getMockCourses();
  
  final country = ref.watch(selectedCountryProvider);
  final grade = ref.watch(selectedGradeProvider);
  final subject = ref.watch(selectedSubjectProvider);

  return courses.where((course) {
    final matchesCountry = country == null || course.country == country;
    final matchesGrade = grade == null || course.grade == grade;
    final matchesSubject = subject == null || course.subject == subject;
    return matchesCountry && matchesGrade && matchesSubject;
  }).toList();
});
