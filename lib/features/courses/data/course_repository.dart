import '../domain/models/course.dart';

class CourseRepository {
  List<Course> getMockCourses() {
    return [
      Course(
        id: '1',
        title: 'الفيزياء للثانوية العامة',
        instructorName: 'أ. أحمد علي',
        thumbnailUrl: 'https://via.placeholder.com/300x200',
        rating: 4.8,
        studentsCount: 1200,
        country: 'مصر',
        grade: 'الصف الثالث الثانوي',
        subject: 'فيزياء',
        isLive: true,
      ),
      Course(
        id: '2',
        title: 'الرياضيات المتقدمة',
        instructorName: 'د. سارة محمود',
        thumbnailUrl: 'https://via.placeholder.com/300x200',
        rating: 4.9,
        studentsCount: 850,
        country: 'مصر',
        grade: 'الصف الثالث الثانوي',
        subject: 'رياضيات',
      ),
      Course(
        id: '3',
        title: 'اللغة العربية لغير الناطقين بها',
        instructorName: 'أ. محمد حسن',
        thumbnailUrl: 'https://via.placeholder.com/300x200',
        rating: 4.7,
        studentsCount: 2000,
        country: 'السعودية',
        grade: 'المرحلة المتوسطة',
        subject: 'لغة عربية',
      ),
      Course(
        id: '4',
        title: 'أساسيات الكيمياء',
        instructorName: 'أ. ليلى خالد',
        thumbnailUrl: 'https://via.placeholder.com/300x200',
        rating: 4.6,
        studentsCount: 600,
        country: 'مصر',
        grade: 'الصف الثاني الثانوي',
        subject: 'كيمياء',
      ),
    ];
  }
}
