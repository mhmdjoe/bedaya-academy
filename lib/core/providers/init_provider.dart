import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amr/features/auth/presentation/providers/auth_providers.dart';

final appInitializedProvider = StateProvider<bool>((ref) => false);

final initializationLogicProvider = FutureProvider<void>((ref) async {
  // Initialize Auth Repository (Load stored data)
  final authRepo = ref.read(authRepositoryProvider);
  await authRepo.init();
  
  // Simulate extra loading time for branded experience
  await Future.delayed(const Duration(seconds: 2));
  ref.read(appInitializedProvider.notifier).state = true;
});
