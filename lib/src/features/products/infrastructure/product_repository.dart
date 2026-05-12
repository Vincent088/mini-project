import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mini_project/src/configs/services/api_client.dart';
import 'package:mini_project/src/constants/app_constants.dart';
import 'package:mini_project/src/features/products/domain/model/product_model.dart';

part 'product_repository.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository(ref.watch(dioProvider));
}

class ProductRepository {
  const ProductRepository(this._dio);
  final dynamic _dio;

  Future<ProductListResponse> getProducts({int limit = 20, int skip = 0}) async {
    final response = await _dio.get(ApiConstants.products, queryParameters: {'limit': limit, 'skip': skip});
    return ProductListResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ProductListResponse> searchProducts(String query, {int limit = 20, int skip = 0}) async {
    final response = await _dio.get(ApiConstants.productsSearch, queryParameters: {'q': query, 'limit': limit, 'skip': skip});
    return ProductListResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await _dio.get('${ApiConstants.products}/$id');
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ProductModel> updateProduct(int id, Map<String, dynamic> data) async {
    final response = await _dio.put('${ApiConstants.products}/$id', data: data);
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteProduct(int id) async {
    await _dio.delete('${ApiConstants.products}/$id');
  }

  Future<ProductModel> addProduct(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConstants.productsAdd, data: data);
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }
}
