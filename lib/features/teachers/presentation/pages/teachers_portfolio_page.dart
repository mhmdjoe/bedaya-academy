import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:amr/features/teachers/data/teachers_repository.dart';
import 'package:amr/features/teachers/presentation/widgets/instructor_card.dart';
import 'package:amr/features/auth/presentation/providers/auth_providers.dart';
import 'package:amr/core/theme/app_theme.dart';

final teachersRepositoryProvider = Provider((ref) => TeachersRepository());

class TeachersPortfolioPage extends ConsumerWidget {
  const TeachersPortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(teachersRepositoryProvider);
    final authRepo = ref.watch(authRepositoryProvider);
    
    // Combine mock teachers with real registered teachers
    final mockTeachers = repo.getMockTeachers();
    final realTeachers = authRepo.getAllTeachers().map((u) => repo.fromUserModel(u)).toList();
    
    // Avoid showing the same teacher twice if they are already in mock
    final teachers = [...mockTeachers, ...realTeachers.where((rt) => !mockTeachers.any((mt) => mt.id == rt.id))];
    
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('نخبة المعلمين'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
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
      body: CustomScrollView(
        slivers: [
          _buildHeroHeader(context),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 4 : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => InstructorCard(instructor: teachers[index]),
                childCount: teachers.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60, horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue,
          image: DecorationImage(
            image: const AssetImage('assets/images/logo.png'),
            opacity: 0.05,
            repeat: ImageRepeat.repeat,
            scale: 0.5,
          ),
        ),
        child: Column(
          children: [
            Text(
              'تعرف على نخبة المعلمين في الوطن العربي',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'نختار معلمينا بعناية فائقة لضمان تقديم أفضل تجربة تعليمية لطلابنا',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: isMobile ? 14 : 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
