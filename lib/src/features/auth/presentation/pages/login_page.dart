import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_project/src/configs/navigations/app_routes.dart';
import 'package:mini_project/src/configs/navigations/app_router.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/components/app_button.dart';
import 'package:mini_project/src/shared/components/app_text_field.dart';
import 'package:mini_project/src/shared/components/app_snackbar.dart';
import 'package:mini_project/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: 'emilys');
  final passwordController = TextEditingController(text: 'emilyspass');
  final obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    obscurePassword.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;
    final controller = ref.read(authControllerProvider.notifier);
    final success = await controller.login(username: usernameController.text.trim(), password: passwordController.text.trim());
    if (!mounted) return;
    if (success) {
      ref.read(appRouterProvider).goNamed(AppRoutes.tabs);
    } else {
      AppSnackbar.error(context, 'Invalid username or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.r(24), vertical: context.r(32)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.r(40)),
                buildHeader(),
                SizedBox(height: context.r(48)),
                AppTextField(
                  controller: usernameController,
                  label: 'Username',
                  hint: 'Enter your username',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => v == null || v.isEmpty ? 'Username is required' : null,
                ),
                SizedBox(height: context.r(16)),
                ValueListenableBuilder<bool>(
                  valueListenable: obscurePassword,
                  builder: (context, obscure, _) => AppTextField(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: obscure,
                    suffixIcon: IconButton(
                      icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppTheme.textSecondary),
                      onPressed: () => obscurePassword.value = !obscurePassword.value,
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Password is required' : null,
                  ),
                ),
                SizedBox(height: context.r(32)),
                Consumer(
                  builder: (context, ref, _) {
                    final isLoading = ref.watch(authControllerProvider).isLoading;
                    return AppButton(label: 'Sign In', isLoading: isLoading, onPressed: isLoading ? null : onLogin);
                  },
                ),
                SizedBox(height: context.r(24)),
                buildDemoHint(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.r(50)),
        Text(
          'Welcome Back!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
        ),
        SizedBox(height: context.r(8)),
        Text('Sign in to continue to DummyShop', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
      ],
    );
  }

  Widget buildDemoHint() {
    return Container(
      padding: EdgeInsets.all(context.r(16)),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demo Credentials',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: context.r(6)),
          Text('Username: emilys', style: Theme.of(context).textTheme.bodySmall),
          Text('Password: emilyspass', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
