import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/features/auth/presentation/pages/login_page.dart';
import 'package:mini_project/src/features/products/presentation/pages/product_detail_page.dart';
import 'package:mini_project/src/features/products/presentation/pages/product_edit_page.dart';
import 'package:mini_project/src/features/tabs/presentation/tabs_screen.dart';
import 'package:mini_project/src/shared/components/splash_screen.dart';
import 'package:mini_project/src/configs/navigations/app_routes.dart';
import 'package:mini_project/src/configs/services/storage_service.dart';
import 'package:mini_project/src/constants/app_constants.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) async {
      final storage = ref.read(storageServiceProvider);
      final token = await storage.getData(StorageKeys.accessToken);
      final isLoggedIn = token != null && token.isNotEmpty;
      final isSplash = state.matchedLocation == AppRoutes.splash;
      final isLogin = state.matchedLocation == AppRoutes.login;

      if (isSplash) return isLoggedIn ? AppRoutes.tabs : AppRoutes.login;
      if (!isLoggedIn && !isLogin) return AppRoutes.login;
      if (isLoggedIn && isLogin) return AppRoutes.tabs;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, name: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, name: AppRoutes.login, builder: (context, state) => const LoginPage()),
      GoRoute(path: AppRoutes.tabs, name: AppRoutes.tabs, builder: (context, state) => const TabsScreen()),
      GoRoute(
        path: AppRoutes.productDetail,
        name: AppRoutes.productDetail,
        builder: (context, state) {
          final productId = state.extra as int;
          return ProductDetailPage(productId: productId);
        },
      ),
      GoRoute(
        path: AppRoutes.productEdit,
        name: AppRoutes.productEdit,
        builder: (context, state) {
          final productId = state.extra as int;
          return ProductEditPage(productId: productId);
        },
      ),
    ],
  );
}
