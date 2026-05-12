import 'package:flutter/material.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(color: AppTheme.primary, strokeWidth: 2)],
        ),
      ),
    );
  }
}
