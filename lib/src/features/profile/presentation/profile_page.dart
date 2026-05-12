import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_project/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:mini_project/src/configs/navigations/app_routes.dart';
import 'package:mini_project/src/configs/navigations/app_router.dart';
import 'package:mini_project/src/configs/themes/app_theme.dart';
import 'package:mini_project/src/features/profile/domain/model/user_model.dart';
import 'package:mini_project/src/shared/components/async_value_widget.dart';
import 'package:mini_project/src/shared/utils/responsive.dart';
import 'package:mini_project/src/features/profile/presentation/controller/profile_controller.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: AsyncValueWidget(
        value: profileAsync,
        onPressed: () => ref.invalidate(profileControllerProvider),
        data: (user) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  buildProfileHeader(context, user.image, user.fullName, user.email),
                  SizedBox(height: context.r(24)),
                  buildInfoCard(context, user),
                  SizedBox(height: context.r(16)),
                  buildMenuSection(context, ref),
                  SizedBox(height: context.r(32)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context, String imageUrl, String name, String email) {
    final avatarSize = context.r(100);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(context.r(24), context.r(60), context.r(24), context.r(40)),
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppTheme.primary, AppTheme.primaryDark], tileMode: TileMode.clamp),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 12)],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                placeholder: (context, _) => Container(
                  width: avatarSize,
                  height: avatarSize,
                  color: Colors.white24,
                  child: Icon(Icons.person, size: context.r(50), color: Colors.white),
                ),
                errorWidget: (context, url, _) => Container(
                  width: avatarSize,
                  height: avatarSize,
                  color: Colors.white24,
                  child: Icon(Icons.person, size: context.r(50), color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: context.r(16)),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: context.sp(22), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: context.r(4)),
          Text(
            email,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: context.sp(14)),
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard(BuildContext context, UserModel user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.r(20)),
      child: Container(
        padding: EdgeInsets.all(context.r(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account Info', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: context.r(16)),
            InfoRow(icon: Icons.person_outline, label: 'Full Name', value: '${user.firstName} ${user.lastName}'),
            Divider(height: context.r(20)),
            InfoRow(icon: Icons.email_outlined, label: 'Email', value: user.email),
          ],
        ),
      ),
    );
  }

  Widget buildMenuSection(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.r(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [MenuItem(icon: Icons.logout_rounded, label: 'Logout', iconColor: AppTheme.error, labelColor: AppTheme.error, onTap: () => onLogout(context, ref))],
        ),
      ),
    );
  }

  Future<void> onLogout(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error, minimumSize: Size.zero, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    await ref.read(authControllerProvider.notifier).logout();
    if (context.mounted) {
      ref.read(appRouterProvider).goNamed(AppRoutes.login);
    }
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: context.r(20), color: AppTheme.textSecondary),
        SizedBox(width: context.r(12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: context.sp(11), color: AppTheme.textSecondary),
            ),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: context.sp(14)),
            ),
          ],
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.icon, required this.label, required this.iconColor, required this.onTap, this.labelColor});

  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: context.r(36),
        height: context.r(36),
        decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: context.r(20)),
      ),
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w500, color: labelColor ?? AppTheme.textPrimary),
      ),
      trailing: Icon(Icons.chevron_right, color: AppTheme.textSecondary, size: context.r(20)),
      onTap: onTap,
    );
  }
}
