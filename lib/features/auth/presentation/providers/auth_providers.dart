import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amr/features/auth/data/auth_repository.dart';
import 'package:amr/features/auth/domain/models/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authStateProvider = StateProvider<UserModel?>((ref) {
  return ref.watch(authRepositoryProvider).currentUser;
});

class AuthNotifier extends StateNotifier<UserModel?> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(_repository.currentUser);

  Future<void> login(String email, String password) async {
    try {
      final user = await _repository.login(email, password);
      state = user;
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  Future<void> signup(
    String email, 
    String password, 
    String name, 
    UserRole role,
    {String? expertise, String? bio, int? experienceYears, List<String>? subjects, double? sessionPrice}
  ) async {
    try {
      final user = await _repository.signup(
        email, password, name, role,
        expertise: expertise,
        bio: bio,
        experienceYears: experienceYears,
        subjects: subjects,
        sessionPrice: sessionPrice,
      );
      state = user;
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  Future<void> loginWithGoogle() async {
    final user = await _repository.loginWithGoogle();
    state = user;
  }

  Future<void> loginWithApple() async {
    final user = await _repository.loginWithApple();
    state = user;
  }

  Future<void> logout() async {
    await _repository.logout();
    state = null;
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
