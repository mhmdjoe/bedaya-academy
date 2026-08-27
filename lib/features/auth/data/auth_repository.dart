import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amr/features/auth/domain/models/user_model.dart';

class AuthRepository {
  UserModel? _currentUser;
  
  // Mock database for the session
  List<Map<String, dynamic>> _registeredUsers = [
    {
      'email': 'test@test.com', 
      'password': 'password123', 
      'name': 'محمد التجريبي',
      'role': UserRole.student,
    },
    {
      'email': 'teacher@test.com',
      'password': 'password123',
      'name': 'أ. أحمد المعلم',
      'role': UserRole.teacher,
      'expertise': 'خبير الفيزياء',
      'bio': 'مدرس فيزياء متخصص.',
      'experienceYears': 10,
      'subjects': ['فيزياء'],
      'sessionPrice': 150.0,
    }
  ];

  Future<void> init() async {
    await _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load Users
    final usersJson = prefs.getString('registered_users');
    if (usersJson != null) {
      final List<dynamic> decoded = json.decode(usersJson);
      _registeredUsers = decoded.map((u) {
        final map = Map<String, dynamic>.from(u);
        map['role'] = UserRole.values[map['role']];
        return map;
      }).toList();
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Save Users
    final usersToSave = _registeredUsers.map((u) {
      final map = Map<String, dynamic>.from(u);
      map['role'] = (map['role'] as UserRole).index;
      return map;
    }).toList();
    await prefs.setString('registered_users', json.encode(usersToSave));
  }

  UserModel? get currentUser => _currentUser;

  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final userMap = _registeredUsers.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => throw Exception('البريد الإلكتروني أو كلمة المرور غير صحيحة'),
    );

    _currentUser = UserModel(
      id: DateTime.now().toString(),
      email: userMap['email']!,
      name: userMap['name']!,
      role: userMap['role']!,
      expertise: userMap['expertise'],
      bio: userMap['bio'],
      experienceYears: userMap['experienceYears'],
      subjects: userMap['subjects'],
      sessionPrice: userMap['sessionPrice'],
    );
    return _currentUser!;
  }

  Future<UserModel> signup(
    String email, 
    String password, 
    String name, 
    UserRole role,
    {String? expertise, String? bio, int? experienceYears, List<String>? subjects, double? sessionPrice}
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_registeredUsers.any((u) => u['email'] == email)) {
      throw Exception('هذا البريد الإلكتروني مسجل بالفعل');
    }

    _registeredUsers.add({
      'email': email,
      'password': password,
      'name': name,
      'role': role,
      'expertise': expertise,
      'bio': bio,
      'experienceYears': experienceYears,
      'subjects': subjects,
      'sessionPrice': sessionPrice,
    });

    await _saveData();
    return login(email, password);
  }

  List<UserModel> getAllTeachers() {
    return _registeredUsers
        .where((u) => u['role'] == UserRole.teacher)
        .map((u) => UserModel(
              id: u['email'],
              email: u['email'],
              name: u['name'],
              role: UserRole.teacher,
              expertise: u['expertise'] ?? 'معلم خبير',
              bio: u['bio'] ?? 'لا يوجد وصف متاح.',
              experienceYears: u['experienceYears'] ?? 5,
              subjects: u['subjects'] ?? ['عام'],
              sessionPrice: u['sessionPrice'] ?? 0.0,
            ))
        .toList();
  }

  Future<UserModel> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = UserModel(
      id: 'google_123',
      email: 'user@google.com',
      name: 'Google User',
      role: UserRole.student,
    );
    return _currentUser!;
  }

  Future<UserModel> loginWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = UserModel(
      id: 'apple_123',
      email: 'user@apple.com',
      name: 'Apple User',
      role: UserRole.student,
    );
    return _currentUser!;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }
}
