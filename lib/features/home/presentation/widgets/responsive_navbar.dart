import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amr/features/auth/presentation/providers/auth_providers.dart';
import 'package:amr/core/theme/app_theme.dart';

class ResponsiveNavbar extends ConsumerWidget implements PreferredSizeWidget {
  const ResponsiveNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final user = ref.watch(authNotifierProvider);

    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          InkWell(
            onTap: () => context.go('/'),
            borderRadius: BorderRadius.circular(25),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (isDesktop) ...[
            const SizedBox(width: 40),
            _NavbarItem(title: 'الرئيسية', onTap: () => context.go('/')),
            _NavbarItem(title: 'الدورات', onTap: () => context.push('/courses')),
            _NavbarItem(title: 'المعلمون', onTap: () => context.push('/teachers')),
            _NavbarItem(title: 'عن المنصة', onTap: () => context.push('/about')),
          ]
        ],
      ),
      actions: [
        if (isDesktop) ...[
          _CountrySelector(),
          const SizedBox(width: 20),
          if (user == null) ...[
            TextButton(
              onPressed: () => context.push('/login'),
              child: const Text('تسجيل دخول', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => context.push('/signup'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.logoCream,
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('إنشاء حساب'),
            ),
          ] else ...[
            Text(
              'أهلاً، ${user.name.split(' ')[0]}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 15),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white70),
              onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
              tooltip: 'تسجيل الخروج',
            ),
          ],
          const SizedBox(width: 20),
        ] else ...[
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {},
          ),
        ]
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavbarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavbarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ),
    );
  }
}

class _CountrySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.location_on, size: 16, color: Colors.white),
          SizedBox(width: 8),
          Text('مصر', style: TextStyle(color: Colors.white)),
          Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
    );
  }
}
