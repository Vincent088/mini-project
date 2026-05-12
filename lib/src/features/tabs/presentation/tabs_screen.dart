import 'package:flutter/material.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';
import 'package:mini_project/src/features/products/presentation/pages/add_product_page.dart';
import 'package:mini_project/src/features/products/presentation/pages/product_list_page.dart';
import 'package:mini_project/src/features/profile/presentation/profile_page.dart';
import 'package:mini_project/src/shared/components/coming_soon_page.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  final currentIndex = ValueNotifier<int>(0);

  static const pages = [
    ProductListPage(),
    ComingSoonPage(title: 'Explore'),
    AddProductPage(),
    ComingSoonPage(title: 'Orders'),
    ProfilePage(),
  ];

  static const tabs = [
    TabItem(icon: Icons.storefront_outlined, activeIcon: Icons.storefront, label: 'Products'),
    TabItem(icon: Icons.explore_outlined, activeIcon: Icons.explore, label: 'Explore'),
    TabItem(icon: Icons.add_circle_outline, activeIcon: Icons.add_circle, label: 'Add'),
    TabItem(icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long, label: 'Orders'),
    TabItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  @override
  void dispose() {
    currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, index, _) => Scaffold(
        body: IndexedStack(
          index: index,
          children: pages,
        ),
        bottomNavigationBar: buildBottomNavBar(context, index),
      ),
    );
  }

  Widget buildBottomNavBar(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r(8), vertical: context.r(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (i) => buildNavItem(context, i, index)),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, int index, int selectedIndex) {
    final tab = tabs[index];
    final isSelected = selectedIndex == index;
    final isCenter = index == 2;

    if (isCenter) {
      return GestureDetector(
        onTap: () => currentIndex.value = index,
        child: Container(
          width: context.r(56),
          height: context.r(56),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primary, AppTheme.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(isSelected ? tab.activeIcon : tab.icon, color: Colors.white, size: context.r(28)),
        ),
      );
    }

    return GestureDetector(
      onTap: () => currentIndex.value = index,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: context.r(16), vertical: context.r(8)),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? tab.activeIcon : tab.icon,
              color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
              size: context.r(24),
            ),
            SizedBox(height: context.r(2)),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: context.sp(11),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabItem {
  const TabItem({required this.icon, required this.activeIcon, required this.label});

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
