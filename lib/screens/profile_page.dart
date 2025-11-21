import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quasar/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authService = AuthService();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            child: const Text('취소'),
            onPressed: () => context.pop(false),
          ),
          TextButton(
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

    return Scaffold(
      appBar: AppBar(title: const Text('프로필')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Icon(Icons.account_circle, size: 100, color: Colors.grey[600]),
              const SizedBox(height: 24),
              Text(
                authService.userName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                authService.userEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _handleLogout(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey[300]!, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('로그아웃'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
