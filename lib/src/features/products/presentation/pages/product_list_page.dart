import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_project/src/configs/navigations/app_router.dart';
import 'package:mini_project/src/configs/navigations/app_routes.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/features/products/domain/model/product_model.dart';
import 'package:mini_project/src/features/profile/presentation/controller/profile_controller.dart';
import 'package:mini_project/src/shared/components/app_loading.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';
import 'package:mini_project/src/shared/components/app_snackbar.dart';
import 'package:mini_project/src/shared/components/async_value_widget.dart';
import '../controller/product_controller.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => ProductListPageState();
}

class ProductListPageState extends ConsumerState<ProductListPage> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  Timer? debounceTimer;
  final searchQuery = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    searchQuery.dispose();
    searchController.dispose();
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(milliseconds: 500), () {
      ref.read(productListControllerProvider.notifier).search(query);
    });
  }

  void clearSearch() {
    debounceTimer?.cancel();
    searchController.clear();
    searchQuery.value = '';
    ref.read(productListControllerProvider.notifier).search('');
  }

  void onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    final nearBottom = position.pixels >= position.maxScrollExtent - 200.0;
    if (nearBottom) {
      ref.read(productListControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            buildSearchBar(),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final productsAsync = ref.watch(productListControllerProvider);
                  return AsyncValueWidget(
                    value: productsAsync,
                    onPressed: () => ref.read(productListControllerProvider.notifier).refresh(),
                    customLoading: const ProductCardShimmer(),
                    skipLoadingOnReload: true,
                    data: (state) => state.isSearching
                        ? const ProductCardShimmer()
                        : state.products.isEmpty
                        ? buildEmpty(state.query)
                        : RefreshIndicator(
                            color: AppTheme.primary,
                            onRefresh: () => ref.read(productListControllerProvider.notifier).refresh(),
                            child: ListView.separated(
                              controller: scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(context.r(16), context.r(8), context.r(16), context.r(16)),
                              itemCount: state.products.length + 1,
                              separatorBuilder: (_, i) => i < state.products.length - 1 ? SizedBox(height: context.r(12)) : const SizedBox.shrink(),
                              itemBuilder: (_, i) {
                                if (i == state.products.length) {
                                  return buildListFooter(state.isLoadingMore, state.hasMore);
                                }
                                return ProductCard(product: state.products[i], onDelete: () => onDelete(state.products[i]));
                              },
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListFooter(bool isLoadingMore, bool hasMore) {
    if (isLoadingMore) {
      return Padding(
        padding: EdgeInsets.only(top: context.r(12)),
        child: ProductCardShimmerItems(count: 3),
      );
    }
    if (!hasMore) {
      return const EndOfListIndicator();
    }
    return SizedBox(height: context.r(80));
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(context.r(20), context.r(20), context.r(20), context.r(4)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back,', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
                Consumer(
                  builder: (context, ref, _) {
                    final profileAsync = ref.watch(profileControllerProvider);
                    final name = profileAsync.valueOrNull?.fullName ?? '';
                    return Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.r(16), vertical: context.r(12)),
      child: ValueListenableBuilder<String>(
        valueListenable: searchQuery,
        builder: (context, query, _) => TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
            suffixIcon: query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: AppTheme.textSecondary),
                    onPressed: clearSearch,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget buildEmpty(String query) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: context.r(64), color: AppTheme.textSecondary),
          SizedBox(height: context.r(16)),
          Text(
            query.isNotEmpty ? 'No products found for "$query"' : 'No products available',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> onDelete(ProductModel product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error, minimumSize: Size.zero, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;
    final success = await ref.read(productListControllerProvider.notifier).deleteProduct(product.id);
    if (!mounted) return;
    if (success) {
      AppSnackbar.success(context, '${product.title} deleted successfully');
    } else {
      AppSnackbar.error(context, 'Failed to delete product');
    }
  }
}

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product, required this.onDelete});

  final ProductModel product;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ref.read(appRouterProvider).pushNamed(AppRoutes.productDetail, extra: product.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                width: context.r(100),
                height: context.r(100),
                fit: BoxFit.cover,
                placeholder: (context, _) => Container(
                  width: context.r(100),
                  height: context.r(100),
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.image_outlined, color: AppTheme.textSecondary),
                ),
                errorWidget: (context, url, _) => Container(
                  width: context.r(100),
                  height: context.r(100),
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.broken_image_outlined, color: AppTheme.textSecondary),
                ),
              ),
            ),
            SizedBox(width: context.r(12)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.r(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: context.sp(14)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.r(4)),
                    Text(
                      product.category,
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: context.sp(12)),
                    ),
                    SizedBox(height: context.r(6)),
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: context.sp(15)),
                        ),
                        SizedBox(width: context.r(8)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: context.r(6), vertical: context.r(2)),
                          decoration: BoxDecoration(color: AppTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            '★ ${product.rating.toStringAsFixed(1)}',
                            style: TextStyle(color: AppTheme.success, fontSize: context.sp(11), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: context.r(20), color: AppTheme.primary),
                  onPressed: () => ref.read(appRouterProvider).pushNamed(AppRoutes.productEdit, extra: product.id),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, size: context.r(20), color: AppTheme.error),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
