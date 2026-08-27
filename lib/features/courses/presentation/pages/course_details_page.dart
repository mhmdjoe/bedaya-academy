import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:amr/features/courses/domain/models/course.dart';
import 'package:amr/features/courses/presentation/providers/course_providers.dart';
import 'package:amr/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsPage extends ConsumerWidget {
  final String courseId;

  const CourseDetailsPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(courseRepositoryProvider).getMockCourses();
    final course = courses.firstWhere((c) => c.id == courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: ClipOval(
              child: Image.asset('assets/images/logo.png', height: 30, width: 30, fit: BoxFit.cover),
            ),
            onPressed: () => context.go('/'),
            tooltip: 'الرئيسية',
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlaceholder(context),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(course),
                  const SizedBox(height: 30),
                  _buildAboutCourse(course),
                  const SizedBox(height: 40),
                  _buildCurriculum(),
                  const SizedBox(height: 40),
                  _buildActionButtons(context, course),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlaceholder(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    return Container(
      width: double.infinity,
      height: isMobile ? 250 : 400,
      color: Colors.black,
      child: Center(
        child: Icon(
          Icons.play_circle_fill, 
          color: Colors.white70, 
          size: isMobile ? 60 : 80,
        ),
      ),
    );
  }

  Widget _buildHeader(Course course) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 15,
              runSpacing: 10,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    course.subject,
                    style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    Text(' ${course.rating} (١٢٠ تقييم)'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              course.title,
              style: TextStyle(
                fontSize: isMobile ? 24 : 32, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'بواسطة ${course.instructorName}',
              style: TextStyle(
                fontSize: isMobile ? 16 : 18, 
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAboutCourse(Course course) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'عن هذه الدورة',
              style: TextStyle(
                fontSize: isMobile ? 20 : 22, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'هذه الدورة مصممة خصيصاً لطلاب المرحلة الثانوية لتغطية كافة جوانب المنهج بأسلوب مبسط وشامل. نركز على الفهم العميق للمفاهيم وحل المسائل المعقدة بطرق مبتكرة.',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16, 
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                _buildFeatureIcon(Icons.access_time, '٢٠ ساعة فيديو'),
                _buildFeatureIcon(Icons.description, '١٥ ملف PDF'),
                _buildFeatureIcon(Icons.live_tv, 'حصص مباشرة'),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCurriculum() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'منهج الدورة',
              style: TextStyle(
                fontSize: isMobile ? 20 : 22, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildModule('الوحدة الأولى: المفاهيم الأساسية', '٤ دروس - ساعة'),
            _buildModule('الوحدة الثانية: التطبيقات العملية', '٦ دروس - ساعتان'),
            _buildModule('الوحدة الثالثة: مراجعة نهائية', '٣ دروس - ٤٥ دقيقة'),
          ],
        );
      },
    );
  }

  Widget _buildModule(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Course course) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showBookingDialog(context, course),
            icon: Icon(Icons.calendar_today, size: isMobile ? 20 : 24),
            label: Text(
              'احجز حصتك الآن', 
              style: TextStyle(fontSize: isMobile ? 16 : 18),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 15 : 20),
              backgroundColor: AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  void _showBookingDialog(BuildContext context, Course course) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حجز حصة تجريبية', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم بالكامل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'العمر',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: course.title,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'المادة المختارة',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'سنقوم بالرد عليك لتحديد الموعد في أقرب وقت ممكن',
                  style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty || ageController.text.isEmpty) return;

              final message = '*طلب حجز حصة جديدة* 🎓\n'
                  '---------------------------\n'
                  '👤 *الاسم:* ${nameController.text}\n'
                  '🎂 *العمر:* ${ageController.text}\n'
                  '📚 *المادة:* ${course.title}\n'
                  '👨‍🏫 *المعلم:* ${course.instructorName}\n'
                  '---------------------------\n'
                  '*يرجى التواصل لترتيب الموعد في أقرب وقت.*';
              
              final encodedMessage = Uri.encodeComponent(message);
              final whatsappUrl = Uri.parse('https://wa.me/+201234567890?text=$encodedMessage');

              if (await canLaunchUrl(whatsappUrl)) {
                await launchUrl(whatsappUrl);
                if (context.mounted) Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
            child: const Text('تأكيد وإرسال عبر واتساب'),
          ),
        ],
      ),
    );
  }
}
