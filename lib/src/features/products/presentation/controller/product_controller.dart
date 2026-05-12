import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/features/products/domain/model/product_list_state.dart';
import 'package:mini_project/src/features/products/domain/model/product_model.dart';
import 'package:mini_project/src/features/products/infrastructure/product_repository.dart';

part 'product_controller.g.dart';

@riverpod
class ProductListController extends _$ProductListController {
  static const pageSize = 20;

  @override
  Future<ProductListState> build() async {
    return initialFetch(query: '');
  }

  Future<ProductListState> initialFetch({required String query}) async {
    final result = await fetchPage(skip: 0, query: query);
    return ProductListState(products: result.products, hasMore: result.products.length < result.total, currentSkip: result.products.length, query: query);
  }

  Future<ProductListResponse> fetchPage({required int skip, required String query}) async {
    final repo = ref.read(productRepositoryProvider);
    return query.isNotEmpty ? repo.searchProducts(query, limit: pageSize, skip: skip) : repo.getProducts(limit: pageSize, skip: skip);
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await fetchPage(skip: current.currentSkip, query: current.query);
      final merged = [...current.products, ...result.products];
      state = AsyncData(ProductListState(products: merged, isLoadingMore: false, hasMore: merged.length < result.total, currentSkip: merged.length, query: current.query));
    } catch (e) {
      debugPrint('loadMore error: $e');
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> search(String query) async {
    state = AsyncData(ProductListState(products: [], isSearching: true, query: query));
    state = await AsyncValue.guard(() => initialFetch(query: query));
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  void updateProductInList(ProductModel updated) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updatedList = current.products.map((p) => p.id == updated.id ? updated : p).toList();
    state = AsyncData(current.copyWith(products: updatedList));
  }

  Future<bool> deleteProduct(int id) async {
    try {
      final repo = ref.read(productRepositoryProvider);
      await repo.deleteProduct(id);
      final current = state.valueOrNull;
      if (current != null) {
        state = AsyncData(current.copyWith(products: current.products.where((p) => p.id != id).toList()));
      }
      return true;
    } catch (e) {
      debugPrint('Delete error: $e');
      return false;
    }
  }
}

@riverpod
class ProductDetailController extends _$ProductDetailController {
  @override
  Future<ProductModel> build(int productId) async {
    final repo = ref.read(productRepositoryProvider);
    return repo.getProductById(productId);
  }

  void setProduct(ProductModel product) => state = AsyncData(product);
}

@riverpod
class ProductEditController extends _$ProductEditController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> update(int id, Map<String, dynamic> data) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(productRepositoryProvider);
      final updated = await repo.updateProduct(id, data);

      ref.read(productDetailControllerProvider(id).notifier).setProduct(updated);
      ref.read(productListControllerProvider.notifier).updateProductInList(updated);

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

@riverpod
class AddProductController extends _$AddProductController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> addProduct(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(productRepositoryProvider);
      await repo.addProduct(data);
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}
