import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:amr/core/theme/app_theme.dart';
import 'package:amr/features/home/presentation/pages/home_page.dart';
import 'package:amr/features/courses/presentation/pages/course_catalog_page.dart';
import 'package:amr/features/auth/presentation/pages/login_page.dart';
import 'package:amr/features/auth/presentation/pages/signup_page.dart';
import 'package:amr/features/splash/presentation/pages/loading_page.dart';
import 'package:amr/features/teachers/presentation/pages/teachers_portfolio_page.dart';
import 'package:amr/features/about/presentation/pages/about_page.dart';
import 'package:amr/features/courses/presentation/pages/course_details_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BedayaApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/courses',
      builder: (context, state) => const CourseCatalogPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/teachers',
      builder: (context, state) => const TeachersPortfolioPage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/course/:id',
      builder: (context, state) => CourseDetailsPage(courseId: state.pathParameters['id']!),
    ),
  ],
);

class BedayaApp extends StatelessWidget {
  const BedayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'أكاديمية بداية - Bidaya Academy',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
      ],
      locale: const Locale('ar', ''),
    );
  }
}
