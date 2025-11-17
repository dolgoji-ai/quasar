import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;

  const LoginPage({super.key, required this.authService});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final account = await widget.authService.signIn();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (account != null && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Quasar',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.label,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '함께하는 이벤트 공간',
                  style: TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 80),
                if (_isLoading)
                  const CupertinoActivityIndicator(
                    radius: 20,
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: _handleSignIn,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(
                            color: const Color(0xFF747775),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/google_g_logo.svg',
                              width: 36,
                              height: 36,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Google 계정으로 로그인',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1F1F1F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}