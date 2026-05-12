import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_project/src/configs/navigations/app_router.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/components/app_button.dart';
import 'package:mini_project/src/shared/components/app_loading.dart';
import 'package:mini_project/src/shared/components/app_snackbar.dart';
import 'package:mini_project/src/shared/components/app_text_field.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';
import 'package:mini_project/src/features/products/presentation/controller/product_controller.dart';

class ProductEditPage extends ConsumerStatefulWidget {
  const ProductEditPage({super.key, required this.productId});

  final int productId;

  @override
  ConsumerState<ProductEditPage> createState() => ProductEditPageState();
}

class ProductEditPageState extends ConsumerState<ProductEditPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final brandController = TextEditingController();
  bool initialized = false;

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    priceController.dispose();
    stockController.dispose();
    brandController.dispose();
    super.dispose();
  }

  void initialize(dynamic product) {
    if (initialized) return;
    initialized = true;
    titleController.text = product.title;
    descController.text = product.description;
    priceController.text = product.price.toString();
    stockController.text = product.stock.toString();
    brandController.text = product.brand;
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) return;
    final success = await ref.read(productEditControllerProvider.notifier).update(
      widget.productId,
      {
        'title': titleController.text.trim(),
        'description': descController.text.trim(),
        'price': double.tryParse(priceController.text.trim()) ?? 0,
        'stock': int.tryParse(stockController.text.trim()) ?? 0,
        'brand': brandController.text.trim(),
      },
    );
    if (!mounted) return;
    if (success) {
      AppSnackbar.success(context, 'Product updated successfully');
      ref.read(appRouterProvider).pop();
    } else {
      AppSnackbar.error(context, 'Failed to update product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Edit Product'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => ref.read(appRouterProvider).pop()),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final productAsync = ref.watch(productDetailControllerProvider(widget.productId));
          return productAsync.when(
            loading: () => const AppLoadingIndicator(),
            error: (e, _) => AppErrorWidget(message: e.toString()),
            data: (product) {
              initialize(product);
              return SingleChildScrollView(
                padding: EdgeInsets.all(context.r(20)),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildImagePreview(product.thumbnail),
                      SizedBox(height: context.r(24)),
                      AppTextField(
                        controller: titleController,
                        label: 'Title',
                        prefixIcon: Icons.title,
                        validator: (v) => v == null || v.isEmpty ? 'Title is required' : null,
                      ),
                      SizedBox(height: context.r(16)),
                      AppTextField(
                        controller: descController,
                        label: 'Description',
                        prefixIcon: Icons.description_outlined,
                        maxLines: 3,
                        validator: (v) => v == null || v.isEmpty ? 'Description is required' : null,
                      ),
                      SizedBox(height: context.r(16)),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: priceController,
                              label: 'Price (\$)',
                              prefixIcon: Icons.attach_money,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                          SizedBox(width: context.r(12)),
                          Expanded(
                            child: AppTextField(
                              controller: stockController,
                              label: 'Stock',
                              prefixIcon: Icons.inventory_outlined,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.r(16)),
                      AppTextField(
                        controller: brandController,
                        label: 'Brand',
                        prefixIcon: Icons.branding_watermark_outlined,
                      ),
                      SizedBox(height: context.r(32)),
                      Consumer(
                        builder: (context, ref, _) {
                          final isLoading = ref.watch(productEditControllerProvider).isLoading;
                          return AppButton(
                            label: 'Save Changes',
                            icon: Icons.save_outlined,
                            isLoading: isLoading,
                            onPressed: isLoading ? null : onSave,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildImagePreview(String thumbnail) {
    return Container(
      height: context.r(180),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100,
        image: DecorationImage(
          image: NetworkImage(thumbnail),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withValues(alpha: 0.2),
        ),
        child: Center(
          child: Icon(Icons.photo_library_outlined, color: Colors.white70, size: context.r(40)),
        ),
      ),
    );
  }
}
