import 'package:flutter/material.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.r(32)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: context.r(100),
                height: context.r(100),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.rocket_launch_outlined, size: context.r(48), color: AppTheme.primary),
              ),
              SizedBox(height: context.r(24)),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
              ),
              SizedBox(height: context.r(12)),
              Text(
                'This feature is under development.\nStay tuned for updates!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.r(32)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.r(20), vertical: context.r(10)),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  'Coming Soon',
                  style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
