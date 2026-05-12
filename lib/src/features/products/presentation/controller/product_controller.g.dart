// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductListController)
final productListControllerProvider = ProductListControllerProvider._();

final class ProductListControllerProvider
    extends $AsyncNotifierProvider<ProductListController, ProductListState> {
  ProductListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productListControllerHash();

  @$internal
  @override
  ProductListController create() => ProductListController();
}

String _$productListControllerHash() =>
    r'f8addc1313f8a58084b2de606a86622f46028313';

abstract class _$ProductListController
    extends $AsyncNotifier<ProductListState> {
  FutureOr<ProductListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProductListState>, ProductListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductListState>, ProductListState>,
              AsyncValue<ProductListState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ProductDetailController)
final productDetailControllerProvider = ProductDetailControllerFamily._();

final class ProductDetailControllerProvider
    extends $AsyncNotifierProvider<ProductDetailController, ProductModel> {
  ProductDetailControllerProvider._({
    required ProductDetailControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'productDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailControllerHash();

  @override
  String toString() {
    return r'productDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductDetailController create() => ProductDetailController();

  @override
  bool operator ==(Object other) {
    return other is ProductDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailControllerHash() =>
    r'cf776d6eb386566b8a5ef6cfd44791de5023beca';

final class ProductDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductDetailController,
          AsyncValue<ProductModel>,
          ProductModel,
          FutureOr<ProductModel>,
          int
        > {
  ProductDetailControllerFamily._()
    : super(
        retry: null,
        name: r'productDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDetailControllerProvider call(int productId) =>
      ProductDetailControllerProvider._(argument: productId, from: this);

  @override
  String toString() => r'productDetailControllerProvider';
}

abstract class _$ProductDetailController extends $AsyncNotifier<ProductModel> {
  late final _$args = ref.$arg as int;
  int get productId => _$args;

  FutureOr<ProductModel> build(int productId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductModel>, ProductModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductModel>, ProductModel>,
              AsyncValue<ProductModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ProductEditController)
final productEditControllerProvider = ProductEditControllerProvider._();

final class ProductEditControllerProvider
    extends $NotifierProvider<ProductEditController, AsyncValue<void>> {
  ProductEditControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productEditControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productEditControllerHash();

  @$internal
  @override
  ProductEditController create() => ProductEditController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$productEditControllerHash() =>
    r'e5a364ab59cf0687e741e11e0c8faf590d195778';

abstract class _$ProductEditController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(AddProductController)
final addProductControllerProvider = AddProductControllerProvider._();

final class AddProductControllerProvider
    extends $NotifierProvider<AddProductController, AsyncValue<void>> {
  AddProductControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addProductControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addProductControllerHash();

  @$internal
  @override
  AddProductController create() => AddProductController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$addProductControllerHash() =>
    r'68068c06be0008fcb53d848255b04ceda59bc193';

abstract class _$AddProductController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
