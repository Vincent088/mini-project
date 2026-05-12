import 'package:flutter/material.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.outlined = false,
    this.color,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool outlined;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppTheme.primary;
    if (outlined) {
      return OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(width: context.r(18), height: context.r(18), child: const CircularProgressIndicator(strokeWidth: 2))
            : Icon(icon ?? Icons.check, size: context.r(18)),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: buttonColor,
          side: BorderSide(color: buttonColor),
          minimumSize: Size(double.infinity, context.r(52)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
      child: isLoading
          ? SizedBox(
              width: context.r(22),
              height: context.r(22),
              child: const CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[Icon(icon, size: context.r(20)), SizedBox(width: context.r(8))],
                Text(label),
              ],
            ),
    );
  }
}

class AppSmallButton extends StatelessWidget {
  const AppSmallButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.color,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? SizedBox(width: context.r(14), height: context.r(14), child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Icon(icon ?? Icons.check, size: context.r(16)),
      label: Text(label, style: TextStyle(fontSize: context.sp(13))),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppTheme.primary,
        padding: EdgeInsets.symmetric(horizontal: context.r(16), vertical: context.r(8)),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
