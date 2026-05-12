// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productListControllerHash() =>
    r'eb2d3139f171014deb91ac28f7a8ab39382bbf7b';

/// See also [ProductListController].
@ProviderFor(ProductListController)
final productListControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      ProductListController,
      ProductListState
    >.internal(
      ProductListController.new,
      name: r'productListControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productListControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProductListController = AutoDisposeAsyncNotifier<ProductListState>;
String _$productDetailControllerHash() =>
    r'cf776d6eb386566b8a5ef6cfd44791de5023beca';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductDetailController
    extends BuildlessAutoDisposeAsyncNotifier<ProductModel> {
  late final int productId;

  FutureOr<ProductModel> build(int productId);
}

/// See also [ProductDetailController].
@ProviderFor(ProductDetailController)
const productDetailControllerProvider = ProductDetailControllerFamily();

/// See also [ProductDetailController].
class ProductDetailControllerFamily extends Family<AsyncValue<ProductModel>> {
  /// See also [ProductDetailController].
  const ProductDetailControllerFamily();

  /// See also [ProductDetailController].
  ProductDetailControllerProvider call(int productId) {
    return ProductDetailControllerProvider(productId);
  }

  @override
  ProductDetailControllerProvider getProviderOverride(
    covariant ProductDetailControllerProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productDetailControllerProvider';
}

/// See also [ProductDetailController].
class ProductDetailControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ProductDetailController,
          ProductModel
        > {
  /// See also [ProductDetailController].
  ProductDetailControllerProvider(int productId)
    : this._internal(
        () => ProductDetailController()..productId = productId,
        from: productDetailControllerProvider,
        name: r'productDetailControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productDetailControllerHash,
        dependencies: ProductDetailControllerFamily._dependencies,
        allTransitiveDependencies:
            ProductDetailControllerFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  FutureOr<ProductModel> runNotifierBuild(
    covariant ProductDetailController notifier,
  ) {
    return notifier.build(productId);
  }

  @override
  Override overrideWith(ProductDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailControllerProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductDetailController, ProductModel>
  createElement() {
    return _ProductDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailControllerProvider &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductDetailControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductModel> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _ProductDetailControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ProductDetailController,
          ProductModel
        >
    with ProductDetailControllerRef {
  _ProductDetailControllerProviderElement(super.provider);

  @override
  int get productId => (origin as ProductDetailControllerProvider).productId;
}

String _$productEditControllerHash() =>
    r'e5a364ab59cf0687e741e11e0c8faf590d195778';

/// See also [ProductEditController].
@ProviderFor(ProductEditController)
final productEditControllerProvider =
    AutoDisposeNotifierProvider<
      ProductEditController,
      AsyncValue<void>
    >.internal(
      ProductEditController.new,
      name: r'productEditControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productEditControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProductEditController = AutoDisposeNotifier<AsyncValue<void>>;
String _$addProductControllerHash() =>
    r'6471ce8983bbd2e8a09ca453dafdcbcb5f1b6a1a';

/// See also [AddProductController].
@ProviderFor(AddProductController)
final addProductControllerProvider =
    AutoDisposeNotifierProvider<
      AddProductController,
      AsyncValue<void>
    >.internal(
      AddProductController.new,
      name: r'addProductControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$addProductControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AddProductController = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
