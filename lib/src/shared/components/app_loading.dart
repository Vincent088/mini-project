import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
  }
}

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.r(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded, size: context.r(100), color: AppTheme.textSecondary),
            SizedBox(height: context.r(16)),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.r(20)),
            if (onRetry != null) ...[
              SizedBox(height: context.r(24)),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh, size: context.r(18)),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: context.r(24), vertical: context.r(12)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        padding: EdgeInsets.all(context.r(16)),
        itemCount: 8,
        separatorBuilder: (context, _) => SizedBox(height: context.r(12)),
        itemBuilder: (context, _) => _ShimmerCard(),
      ),
    );
  }
}

class ProductCardShimmerItems extends StatelessWidget {
  const ProductCardShimmerItems({super.key, this.count = 3});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: List.generate(count, (_) => Padding(padding: EdgeInsets.only(bottom: context.r(12)), child: _ShimmerCard())),
      ),
    );
  }
}

class EndOfListIndicator extends StatelessWidget {
  const EndOfListIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.r(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: context.r(40), height: 1, color: Colors.grey.shade300),
          SizedBox(width: context.r(12)),
          Text('All products loaded', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
          SizedBox(width: context.r(12)),
          Container(width: context.r(40), height: 1, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = context.r(100);
    return Container(
      height: size,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            ),
          ),
          SizedBox(width: context.r(12)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.r(14), horizontal: context.r(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(height: context.r(14), width: double.infinity, color: Colors.white),
                  Container(height: context.r(10), width: context.r(100), color: Colors.white),
                  Container(height: context.r(14), width: context.r(80), color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
