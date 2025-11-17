import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authService = AuthService();

    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃 하시겠습니까?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => context.pop(false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('로그아웃'),
            onPressed: () => context.pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await authService.signOut();

      if (context.mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('프로필')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Icon(
                CupertinoIcons.person_circle_fill,
                size: 100,
                color: CupertinoColors.systemGrey,
              ),
              const SizedBox(height: 24),
              Text(
                authService.userName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                authService.userEmail,
                style: const TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 40),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () => _handleLogout(context),
                  child: const Text('로그아웃'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
