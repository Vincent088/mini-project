import 'package:mini_project/src/features/products/domain/model/product_model.dart';

class ProductListState {
  final List<ProductModel> products;
  final bool isLoadingMore;
  final bool isSearching;
  final bool hasMore;
  final int currentSkip;
  final String query;

  const ProductListState({
    required this.products,
    this.isLoadingMore = false,
    this.isSearching = false,
    this.hasMore = true,
    this.currentSkip = 0,
    this.query = '',
  });

  ProductListState copyWith({
    List<ProductModel>? products,
    bool? isLoadingMore,
    bool? isSearching,
    bool? hasMore,
    int? currentSkip,
    String? query,
  }) =>
      ProductListState(
        products: products ?? this.products,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isSearching: isSearching ?? this.isSearching,
        hasMore: hasMore ?? this.hasMore,
        currentSkip: currentSkip ?? this.currentSkip,
        query: query ?? this.query,
      );
}
