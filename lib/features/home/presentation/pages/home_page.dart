import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amr/features/auth/presentation/providers/auth_providers.dart';
import 'package:amr/core/theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider);
    return Scaffold(
      appBar: const ResponsiveNavbar(),
      drawer: MediaQuery.of(context).size.width <= 900
          ? Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Color(0xFF1A435D)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Bidaya Academy',
                            style: TextStyle(color: AppTheme.logoCream, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(title: const Text('الرئيسية'), onTap: () => context.go('/')),
                  ListTile(title: const Text('الدورات'), onTap: () => context.push('/courses')),
                  ListTile(title: const Text('المعلمون'), onTap: () => context.push('/teachers')),
                  ListTile(title: const Text('عن المنصة'), onTap: () => context.push('/about')),
                  const Divider(),
                  if (user == null) ...[
                    ListTile(title: const Text('تسجيل دخول'), onTap: () => context.push('/login')),
                    ListTile(
                      title: const Text('إنشاء حساب'),
                      tileColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      onTap: () => context.push('/signup'),
                    ),
                  ] else ...[
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('تسجيل الخروج'),
                      onTap: () => ref.read(authNotifierProvider.notifier).logout(),
                    ),
                  ],
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildTrustSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            'لماذا يختار الطلاب منصة بداية؟',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 28, 
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 40),
          isMobile 
            ? Column(
                children: [
                  _buildStatCard('١٠٠+', 'دورة تدريبية'),
                  const SizedBox(height: 30),
                  _buildStatCard('٥٠ ألف+', 'طالب مسجل'),
                  const SizedBox(height: 30),
                  _buildStatCard('٤.٩/٥', 'تقييم المنصة'),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard('١٠٠+', 'دورة تدريبية'),
                  _buildStatCard('٥٠ ألف+', 'طالب مسجل'),
                  _buildStatCard('٤.٩/٥', 'تقييم المنصة'),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width <= 600;
        return Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 28 : 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0D47A1),
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.grey),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100, 
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue,
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1588196749597-9ff075ee6b5b?q=80&w=1374&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // The Logo as the centerpiece
          ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              height: isMobile ? 150 : 240,
              width: isMobile ? 150 : 240,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: isMobile ? 30 : 40),
          Text(
            'البداية نحو التميز',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.logoCream,
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(color: Colors.black.withValues(alpha: 0.5), offset: const Offset(0, 2), blurRadius: 10),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 40),
            child: Text(
              'منصة تعليمية متكاملة لدعم الطلاب في الوطن العربي بمناهج دراسية متطورة ونخبة من أفضل المعلمين',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.logoCream,
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(color: Colors.black.withValues(alpha: 0.5), offset: const Offset(0, 2), blurRadius: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: isMobile ? 40 : 50),
          isMobile
              ? Column(
                  children: [
                    _buildHeroButton(
                      context, 
                      'ابدأ التعلم الآن', 
                      () => context.push('/courses'),
                      isPrimary: true,
                    ),
                    const SizedBox(height: 15),
                    _buildHeroButton(
                      context, 
                      'تعرف على معلمينا', 
                      () => context.push('/teachers'),
                      isPrimary: false,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeroButton(
                      context, 
                      'ابدأ التعلم الآن', 
                      () => context.push('/courses'),
                      isPrimary: true,
                    ),
                    const SizedBox(width: 25),
                    _buildHeroButton(
                      context, 
                      'تعرف على معلمينا', 
                      () => context.push('/teachers'),
                      isPrimary: false,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeroButton(BuildContext context, String text, VoidCallback onPressed, {required bool isPrimary}) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    
    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.logoCream,
          foregroundColor: AppTheme.primaryBlue,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 40 : 50, 
            vertical: isMobile ? 20 : 25,
          ),
          textStyle: TextStyle(
            fontSize: isMobile ? 18 : 20, 
            fontWeight: FontWeight.bold,
          ),
          minimumSize: isMobile ? const Size(double.infinity, 0) : null,
        ),
        child: Text(text),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.logoCream,
          side: const BorderSide(color: AppTheme.logoCream, width: 2),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 40 : 50, 
            vertical: isMobile ? 20 : 25,
          ),
          textStyle: TextStyle(
            fontSize: isMobile ? 18 : 20, 
            fontWeight: FontWeight.bold,
          ),
          minimumSize: isMobile ? const Size(double.infinity, 0) : null,
        ),
        child: Text(text),
      );
    }
  }
}
