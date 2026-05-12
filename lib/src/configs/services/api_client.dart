import 'package:dio/dio.dart';
import 'package:mini_project/src/configs/navigations/app_router.dart';
import 'package:mini_project/src/configs/navigations/app_routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/constants/app_constants.dart';
import 'package:mini_project/src/configs/services/storage_service.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl, connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 15), headers: {'Content-Type': 'application/json'}));

  bool isHandling401 = false;

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final storage = ref.read(storageServiceProvider);
        final token = await storage.getData(StorageKeys.accessToken);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401 && !isHandling401) {
          isHandling401 = true;
          await ref.read(storageServiceProvider).clearAll();
          ref.read(appRouterProvider).goNamed(AppRoutes.login);
        }
        handler.reject(error);
      },
    ),
  );

  return dio;
}
