import 'package:flutter/material.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';

class AppSnackbar {
  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(Icons.error_outline, color: Colors.white, size: context.r(20)),
          SizedBox(width: context.r(8)),
          Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
        ]),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(context.r(16)),
      ),
    );
  }

  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(Icons.check_circle_outline, color: Colors.white, size: context.r(20)),
          SizedBox(width: context.r(8)),
          Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
        ]),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(context.r(16)),
      ),
    );
  }
}
