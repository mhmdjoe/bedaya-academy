import '../domain/models/instructor.dart';
import 'package:amr/features/auth/domain/models/user_model.dart';

class TeachersRepository {
  List<Instructor> getMockTeachers() {
    return [
      Instructor(
        id: 't1',
        name: 'أ. أحمد علي',
        expertise: 'خبير الفيزياء للثانوية العامة',
        bio: 'خبرة أكثر من ١٥ عاماً في تبسيط مفاهيم الفيزياء لطلاب المرحلة الثانوية.',
        photoUrl: 'https://via.placeholder.com/300',
        rating: 4.9,
        experienceYears: 15,
        subjects: ['فيزياء', 'علوم'],
      ),
      Instructor(
        id: 't2',
        name: 'د. سارة محمود',
        expertise: 'دكتوراه في الرياضيات التطبيقية',
        bio: 'متخصصة في تدريس الرياضيات المتقدمة بأسلوب تفاعلي وممتع.',
        photoUrl: 'https://via.placeholder.com/300',
        rating: 4.8,
        experienceYears: 10,
        subjects: ['رياضيات', 'إحصاء'],
      ),
      Instructor(
        id: 't3',
        name: 'أ. محمد حسن',
        expertise: 'ماجستير اللغة العربية والآداب',
        bio: 'مدرس متميز في اللغة العربية والنحو والصرف لمختلف المراحل الدراسية.',
        photoUrl: 'https://via.placeholder.com/300',
        rating: 4.7,
        experienceYears: 12,
        subjects: ['لغة عربية', 'أدب'],
      ),
      Instructor(
        id: 't4',
        name: 'أ. ليلى خالد',
        expertise: 'خبيرة الكيمياء والعلوم الحيوية',
        bio: 'مدرسة مبدعة تهدف إلى تحويل الكيمياء من مادة معقدة إلى تجربة استكشافية.',
        photoUrl: 'https://via.placeholder.com/300',
        rating: 4.6,
        experienceYears: 8,
        subjects: ['كيمياء', 'أحياء'],
      ),
    ];
  }

  Instructor fromUserModel(UserModel user) {
    return Instructor(
      id: user.id,
      name: user.name,
      expertise: user.expertise ?? 'معلم خبير',
      bio: user.bio ?? 'لا يوجد وصف متاح.',
      photoUrl: user.photoUrl ?? 'https://via.placeholder.com/300',
      rating: user.rating,
      experienceYears: user.experienceYears ?? 5,
      subjects: user.subjects ?? ['عام'],
      sessionPrice: user.sessionPrice ?? 0.0,
    );
  }
}
