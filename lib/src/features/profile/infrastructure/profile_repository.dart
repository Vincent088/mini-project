import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/configs/services/api_client.dart';
import 'package:mini_project/src/constants/app_constants.dart';
import 'package:mini_project/src/features/profile/domain/model/user_model.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(ref.watch(dioProvider));
}

class ProfileRepository {
  const ProfileRepository(this._dio);
  final dynamic _dio;

  Future<UserModel> getMe() async {
    final response = await _dio.get(ApiConstants.me);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
