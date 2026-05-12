import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/configs/services/api_client.dart';
import 'package:mini_project/src/constants/app_constants.dart';
import 'package:mini_project/src/features/auth/domain/model/auth_model.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(dioProvider));
}

class AuthRepository {
  const AuthRepository(this._dio);
  final dynamic _dio;

  Future<AuthModel> login({required String username, required String password}) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {
        'username': username,
        'password': password,
        'expiresInMins': 60,
      },
    );
    return AuthModel.fromJson(response.data as Map<String, dynamic>);
  }
}
