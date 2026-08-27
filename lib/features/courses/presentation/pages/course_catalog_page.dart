import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:amr/features/courses/presentation/providers/course_flow_provider.dart';
import 'package:amr/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCatalogPage extends ConsumerWidget {
  const CourseCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowState = ref.watch(courseFlowProvider);
    final flowNotifier = ref.read(courseFlowProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('رحلة التعلم ✨'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (flowState.currentStep == CourseFlowStep.country) {
              context.go('/');
            } else {
              flowNotifier.goBack();
            }
          },
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressIndicator(context, flowState.currentStep),
                const SizedBox(height: 50),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(flowState.currentStep),
                    child: _buildCurrentStep(context, ref, flowState),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, CourseFlowStep step) {
    final totalSteps = CourseFlowStep.values.length;
    final currentStepIndex = step.index;
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: (currentStepIndex + 1) / totalSteps,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
            minHeight: isMobile ? 8 : 12,
          ),
        ),
        SizedBox(height: isMobile ? 10 : 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تقدمك في الاختيار: ', 
              style: TextStyle(color: Colors.grey, fontSize: isMobile ? 14 : 16),
            ),
            Text(
              '${((currentStepIndex + 1) / totalSteps * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: AppTheme.primaryBlue,
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrentStep(BuildContext context, WidgetRef ref, CourseFlowState state) {
    switch (state.currentStep) {
      case CourseFlowStep.country:
        return _buildSelectionGrid(
          context,
          ref,
          title: 'أهلاً بك! اختر دولتك الجميلة 🌍',
          options: ['مصر 🇪🇬', 'السعودية 🇸🇦', 'الإمارات 🇦🇪', 'الأردن 🇯🇴', 'الكويت 🇰🇼', 'عمان 🇴🇲'],
          onSelect: (val) => ref.read(courseFlowProvider.notifier).selectCountry(val),
        );
      case CourseFlowStep.category:
        return _buildSelectionGrid(
          context,
          ref,
          title: 'ما هو هدفك التعليمي اليوم؟ 🎯',
          options: ['مناهج دراسية 📚', 'كورسات 💻'],
          onSelect: (val) {
            final category = val.contains('مناهج') ? 'مناهج دراسية' : 'كورسات';
            ref.read(courseFlowProvider.notifier).selectCategory(category);
          },
          isLarge: true,
        );
      case CourseFlowStep.stage:
        return _buildSelectionGrid(
          context,
          ref,
          title: 'اختر مرحلتك الدراسية الحالية 🎓',
          options: ['المرحلة الابتدائية 👦👧', 'المرحلة الإعدادية 🧑‍🎓'],
          onSelect: (val) {
            final stage = val.contains('الابتدائية') ? 'المرحلة الابتدائية' : 'المرحلة الإعدادية';
            ref.read(courseFlowProvider.notifier).selectStage(stage);
          },
          isLarge: true,
        );
      case CourseFlowStep.grade:
        final options = state.selectedStage == 'المرحلة الابتدائية'
            ? ['الصف الأول 1️⃣', 'الصف الثاني 2️⃣', 'الصف الثالث 3️⃣', 'الصف الرابع 4️⃣', 'الصف الخامس 5️⃣', 'الصف السادس 6️⃣']
            : ['الصف الأول الإعدادي 1️⃣', 'الصف الثاني الإعدادي 2️⃣', 'الصف الثالث الإعدادي 3️⃣'];
        return _buildSelectionGrid(
          context,
          ref,
          title: 'في أي صف دراسي أنت؟ 📝',
          options: options,
          onSelect: (val) => ref.read(courseFlowProvider.notifier).selectGrade(val),
        );
      case CourseFlowStep.finalInfo:
        return _buildFinalScreen(context, ref, state);
    }
  }

  Widget _buildSelectionGrid(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required List<String> options,
    required Function(String) onSelect,
    bool isLarge = false,
  }) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 24 : 32, 
            fontWeight: FontWeight.bold, 
            color: AppTheme.primaryBlue,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isMobile ? 30 : 50),
        Wrap(
          spacing: isMobile ? 15 : 25,
          runSpacing: isMobile ? 15 : 25,
          alignment: WrapAlignment.center,
          children: options.map((option) {
            return _AnimatedOptionCard(
              title: option,
              isLarge: isLarge,
              onTap: () => onSelect(option),
            );
          }).toList(),
        ),
        if (ref.watch(courseFlowProvider).currentStep != CourseFlowStep.country) ...[
          SizedBox(height: isMobile ? 40 : 60),
          TextButton.icon(
            onPressed: () => ref.read(courseFlowProvider.notifier).goBack(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            label: Text('العودة للخطوة السابقة', style: TextStyle(fontSize: isMobile ? 16 : 18)),
            style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
          ),
        ],
      ],
    );
  }

  Widget _buildFinalScreen(BuildContext context, WidgetRef ref, CourseFlowState state) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    final levelInfo = state.selectedCategory == 'كورسات' 
        ? 'قسم الكورسات العامة 🚀'
        : '${state.selectedStage} - ${state.selectedGrade}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: AppTheme.primaryGreen.withValues(alpha: 0.1), blurRadius: 40, spreadRadius: 5),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 30 : 50),
        child: Column(
          children: [
            Text('🎉', style: TextStyle(fontSize: isMobile ? 60 : 80)),
            const SizedBox(height: 20),
            Text(
              'رائع! نحن مستعدون لك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 24 : 30, 
                fontWeight: FontWeight.bold, 
                color: AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'أكاديمية بداية توفر كل ما تحتاجه للتميز في:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 30, 
                vertical: 15,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.primaryBlue, AppTheme.primaryBlue.withValues(alpha: 0.8)]),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                levelInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold, 
                  fontSize: isMobile ? 18 : 22,
                ),
              ),
            ),
            SizedBox(height: isMobile ? 40 : 50),
            SizedBox(
              width: double.infinity,
              height: isMobile ? 60 : 65,
              child: ElevatedButton.icon(
                onPressed: () => _showBookingDialog(context, state),
                icon: Icon(Icons.bolt_rounded, size: isMobile ? 24 : 28),
                label: Text(
                  'احجز حصتك المجانية الآن!', 
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () => ref.read(courseFlowProvider.notifier).reset(),
              child: Text('البدء من جديد ✨', style: TextStyle(fontSize: isMobile ? 14 : 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context, CourseFlowState state) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final levelInfo = state.selectedCategory == 'كورسات' 
        ? 'كورسات عامة'
        : '${state.selectedCountry} - ${state.selectedCategory} - ${state.selectedStage} - ${state.selectedGrade}';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('خطوة واحدة للتميز 🚀', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسمك الجميل 😊',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_pin_rounded),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'كم عمرك؟ 🎂',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake_rounded),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: levelInfo,
                enabled: false,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'مستواك الذي اخترته 📚',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.auto_awesome_rounded),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryBlue)),
                ),
                style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '⚡ سنقوم بالرد عليك لتحديد الموعد في أقرب وقت ممكن.',
                  style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty || ageController.text.isEmpty) return;

              final message = '*طلب حجز حصة جديدة* 🎓\n'
                  '---------------------------\n'
                  '👤 *الاسم:* ${nameController.text}\n'
                  '🎂 *العمر:* ${ageController.text}\n'
                  '📚 *المستوى:* $levelInfo\n'
                  '---------------------------\n'
                  '*يرجى التواصل لترتيب الموعد في أقرب وقت.*';
              
              final encodedMessage = Uri.encodeComponent(message);
              final whatsappUrl = Uri.parse('https://wa.me/+201000855167?text=$encodedMessage');

              if (await canLaunchUrl(whatsappUrl)) {
                await launchUrl(whatsappUrl);
                if (context.mounted) Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen, foregroundColor: Colors.white),
            child: const Text('تأكيد وإرسال 🚀'),
          ),
        ],
      ),
    );
  }
}

class _AnimatedOptionCard extends StatefulWidget {
  final String title;
  final bool isLarge;
  final VoidCallback onTap;

  const _AnimatedOptionCard({required this.title, required this.isLarge, required this.onTap});

  @override
  State<_AnimatedOptionCard> createState() => _AnimatedOptionCardState();
}

class _AnimatedOptionCardState extends State<_AnimatedOptionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isMobile ? double.infinity : (widget.isLarge ? 320 : 180),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 25 : 40, 
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.primaryBlue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _isHovered ? AppTheme.primaryBlue : Colors.grey.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? AppTheme.primaryBlue.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.05),
                blurRadius: _isHovered ? 20 : 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.bold,
              color: _isHovered ? Colors.white : AppTheme.primaryBlue,
            ),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
