import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/components/app_button.dart';
import 'package:mini_project/src/shared/components/app_snackbar.dart';
import 'package:mini_project/src/shared/components/app_text_field.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';
import 'package:mini_project/src/features/products/presentation/controller/product_controller.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<AddProductPage> createState() => AddProductPageState();
}

class AddProductPageState extends ConsumerState<AddProductPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final brandController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    priceController.dispose();
    stockController.dispose();
    brandController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) return;
    final success = await ref.read(addProductControllerProvider.notifier).addProduct({
      'title': titleController.text.trim(),
      'description': descController.text.trim(),
      'price': double.tryParse(priceController.text.trim()) ?? 0,
      'stock': int.tryParse(stockController.text.trim()) ?? 0,
      'brand': brandController.text.trim(),
      'category': categoryController.text.trim(),
    });
    if (!mounted) return;
    if (success) {
      AppSnackbar.success(context, 'Product added successfully!');
      formKey.currentState!.reset();
      titleController.clear();
      descController.clear();
      priceController.clear();
      stockController.clear();
      brandController.clear();
      categoryController.clear();
    } else {
      AppSnackbar.error(context, 'Failed to add product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.r(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.r(8)),
              buildPageHeader(context),
              SizedBox(height: context.r(28)),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextField(
                      controller: titleController,
                      label: 'Product Title',
                      hint: 'e.g. iPhone 15 Pro',
                      prefixIcon: Icons.title,
                      validator: (v) => v == null || v.isEmpty ? 'Title is required' : null,
                    ),
                    SizedBox(height: context.r(16)),
                    AppTextField(
                      controller: descController,
                      label: 'Description',
                      hint: 'Describe your product...',
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
                            hint: '0.00',
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
                            hint: '0',
                            prefixIcon: Icons.inventory_outlined,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.r(16)),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(controller: brandController, label: 'Brand', hint: 'e.g. Apple', prefixIcon: Icons.branding_watermark_outlined),
                        ),
                        SizedBox(width: context.r(12)),
                        Expanded(
                          child: AppTextField(
                            controller: categoryController,
                            label: 'Category',
                            hint: 'e.g. smartphones',
                            prefixIcon: Icons.category_outlined,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.r(32)),
                    Consumer(
                      builder: (context, ref, _) {
                        final isLoading = ref.watch(addProductControllerProvider).isLoading;
                        return AppButton(label: 'Add Product', icon: Icons.add_circle_outline, isLoading: isLoading, onPressed: isLoading ? null : onSubmit);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: context.r(48),
          height: context.r(48),
          decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
          child: Icon(Icons.add_shopping_cart_outlined, color: AppTheme.primary, size: context.r(26)),
        ),
        SizedBox(height: context.r(16)),
        Text('Add New Product', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: context.r(4)),
        Text('Fill in the details to list a new product', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
      ],
    );
  }
}
