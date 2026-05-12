import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/features/profile/domain/model/user_model.dart';
import 'package:mini_project/src/features/profile/infrastructure/profile_repository.dart';

part 'profile_controller.g.dart';

@riverpod
Future<UserModel> profileController(Ref ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getMe();
}
