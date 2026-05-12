import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/configs/services/storage_service.dart';
import 'package:mini_project/src/constants/app_constants.dart';
import 'package:mini_project/src/features/auth/infrastructure/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> login({required String username, required String password}) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.login(username: username, password: password);

      final storage = ref.read(storageServiceProvider);
      await storage.setData(StorageKeys.accessToken, result.accessToken);
      await storage.setData(StorageKeys.refreshToken, result.refreshToken);
      await storage.setData(StorageKeys.userFirstName, result.firstName);
      await storage.setData(StorageKeys.userLastName, result.lastName);
      await storage.setData(StorageKeys.userEmail, result.email);
      await storage.setData(StorageKeys.userAvatar, result.image);
      await storage.setData(StorageKeys.userId, result.id.toString());

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      debugPrint('Login error: $e');
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<void> logout() async {
    final storage = ref.read(storageServiceProvider);
    await storage.clearAll();
    state = const AsyncData(null);
  }
}
