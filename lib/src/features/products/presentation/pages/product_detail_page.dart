import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_project/src/configs/navigations/app_routes.dart';
import 'package:mini_project/src/configs/navigations/app_router.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/features/products/presentation/controller/product_controller.dart';
import 'package:mini_project/src/shared/components/async_value_widget.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailControllerProvider(productId));

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: AsyncValueWidget(
        value: productAsync,
        onPressed: () => ref.invalidate(productDetailControllerProvider(productId)),
        data: (product) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: context.r(280),
              pinned: true,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(context.r(8)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8)],
                  ),
                  child: Icon(Icons.arrow_back, size: context.r(20)),
                ),
                onPressed: () => ref.read(appRouterProvider).pop(),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(context.r(8)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8)],
                    ),
                    child: Icon(Icons.edit_outlined, size: context.r(20), color: AppTheme.primary),
                  ),
                  onPressed: () => ref.read(appRouterProvider).pushNamed(AppRoutes.productEdit, extra: product.id),
                ),
                SizedBox(width: context.r(8)),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: product.images.isNotEmpty
                    ? PageView.builder(
                        itemCount: product.images.length,
                        itemBuilder: (_, i) => CachedNetworkImage(
                          imageUrl: product.images[i],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, _) => Center(child: Icon(Icons.broken_image_outlined, size: context.r(64), color: AppTheme.textSecondary)),
                        ),
                      )
                    : CachedNetworkImage(imageUrl: product.thumbnail, fit: BoxFit.cover),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(context.r(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(product.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(height: context.r(8)),
                    Row(
                      children: [
                        DetailChip(label: product.category, color: AppTheme.primary),
                        SizedBox(width: context.r(8)),
                        if (product.brand.isNotEmpty) DetailChip(label: product.brand, color: AppTheme.secondary),
                      ],
                    ),
                    SizedBox(height: context.r(16)),
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: context.sp(28), fontWeight: FontWeight.bold, color: AppTheme.primary),
                        ),
                        SizedBox(width: context.r(12)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: context.r(8), vertical: context.r(4)),
                          decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            '-${product.discountPercentage.toStringAsFixed(0)}%',
                            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.r(16)),
                    Row(
                      children: [
                        DetailStatCard(icon: Icons.star_rounded, label: 'Rating', value: product.rating.toStringAsFixed(1), color: Colors.amber),
                        SizedBox(width: context.r(12)),
                        DetailStatCard(icon: Icons.inventory_2_outlined, label: 'Stock', value: '${product.stock}', color: product.stock > 10 ? AppTheme.success : AppTheme.error),
                        SizedBox(width: context.r(12)),
                        DetailStatCard(icon: Icons.local_offer_outlined, label: 'Discount', value: '${product.discountPercentage.toStringAsFixed(0)}%', color: Colors.orange),
                      ],
                    ),
                    SizedBox(height: context.r(20)),
                    Text('Description', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: context.r(8)),
                    Text(product.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary, height: 1.6)),
                    SizedBox(height: context.r(32)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailChip extends StatelessWidget {
  const DetailChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.r(10), vertical: context.r(4)),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: context.sp(12), fontWeight: FontWeight.w600),
      ),
    );
  }
}

class DetailStatCard extends StatelessWidget {
  const DetailStatCard({super.key, required this.icon, required this.label, required this.value, required this.color});

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.r(12), horizontal: context.r(8)),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, color: color, size: context.r(22)),
            SizedBox(height: context.r(4)),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: context.sp(15)),
            ),
            Text(label, style: TextStyle(fontSize: context.sp(11), color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}
