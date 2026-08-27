import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:amr/features/auth/presentation/providers/auth_providers.dart';
import 'package:amr/features/auth/domain/models/user_model.dart';
import 'package:amr/core/theme/app_theme.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Teacher specific controllers
  final _expertiseController = TextEditingController();
  final _bioController = TextEditingController();
  final _experienceController = TextEditingController();
  final _subjectsController = TextEditingController();
  final _priceController = TextEditingController();

  UserRole _selectedRole = UserRole.student;
  bool _isLoading = false;

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(authNotifierProvider.notifier).signup(
            _emailController.text,
            _passwordController.text,
            _nameController.text,
            _selectedRole,
            expertise: _selectedRole == UserRole.teacher ? _expertiseController.text : null,
            bio: _selectedRole == UserRole.teacher ? _bioController.text : null,
            experienceYears: _selectedRole == UserRole.teacher 
              ? int.tryParse(_experienceController.text) 
              : null,
            subjects: _selectedRole == UserRole.teacher 
              ? _subjectsController.text.split(',').map((s) => s.trim()).toList() 
              : null,
            sessionPrice: _selectedRole == UserRole.teacher 
              ? double.tryParse(_priceController.text) 
              : null,
          );
      if (mounted) context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (isDesktop)
            Expanded(
              child: Container(
                color: AppTheme.primaryBlue,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Bidaya Academy',
                        style: TextStyle(
                          color: AppTheme.logoCream,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'The Beginning of Excellence',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إنشاء حساب جديد',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width <= 600 ? 28 : 32, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('انضم إلى مجتمع التميز اليوم'),
                          const SizedBox(height: 30),
                          const Text('أنا:', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          SegmentedButton<UserRole>(
                            segments: const [
                              ButtonSegment(
                                value: UserRole.student,
                                label: Text('طالب'),
                                icon: Icon(Icons.school),
                              ),
                              ButtonSegment(
                                value: UserRole.teacher,
                                label: Text('معلم'),
                                icon: Icon(Icons.person),
                              ),
                            ],
                            selected: {_selectedRole},
                            onSelectionChanged: (Set<UserRole> newSelection) {
                              setState(() {
                                _selectedRole = newSelection.first;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'الاسم الكامل',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'يرجى إدخال اسمك';
                              return null;
                            },
                          ),
                          if (_selectedRole == UserRole.teacher) ...[
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _expertiseController,
                              decoration: const InputDecoration(
                                labelText: 'التخصص (مثلاً: دكتوراه في الفيزياء)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.workspace_premium_outlined),
                              ),
                              validator: (v) => v!.isEmpty ? 'يرجى إدخال التخصص' : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _experienceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'سنوات الخبرة',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.history_edu_outlined),
                              ),
                              validator: (v) => v!.isEmpty ? 'يرجى إدخال سنوات الخبرة' : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _subjectsController,
                              decoration: const InputDecoration(
                                labelText: 'المواد (افصل بينها بفاصلة)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.book_outlined),
                              ),
                              validator: (v) => v!.isEmpty ? 'يرجى إدخال المواد' : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'سعر الحصة (ج.م)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.payments_outlined),
                              ),
                              validator: (v) => v!.isEmpty ? 'يرجى إدخال سعر الحصة' : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _bioController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'نبذة تعريفية قصيرة',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.info_outline),
                              ),
                              validator: (v) => v!.isEmpty ? 'يرجى إدخال نبذة عنك' : null,
                            ),
                          ],
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
                              if (!value.contains('@')) return 'يرجى إدخال بريد إلكتروني صحيح';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'كلمة المرور',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
                              if (value.length < 6) return 'كلمة المرور يجب أن تكون ٦ أحرف على الأقل';
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSignup,
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('إنشاء حساب'),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('لديك حساب بالفعل؟'),
                              TextButton(
                                onPressed: () => context.pop(),
                                child: const Text('سجل دخولك'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
