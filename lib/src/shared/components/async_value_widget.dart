import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_project/src/shared/components/app_loading.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data, required this.onPressed, this.customLoading, this.onError, this.skipError = false, this.skipLoadingOnReload = false});

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final VoidCallback onPressed;
  final Widget? customLoading;
  final Widget Function(Object error, StackTrace st)? onError;
  final bool skipError;
  final bool skipLoadingOnReload;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipError: skipError,
      skipLoadingOnReload: skipLoadingOnReload,
      data: data,
      loading: () => customLoading ?? const AppLoadingIndicator(),
      error: onError ?? (e, st) => AppErrorWidget(message: e.toString(), onRetry: onPressed),
    );
  }
}
