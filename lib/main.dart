import 'package:flutter/cupertino.dart';
import 'services/auth_service.dart';
import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  late final AppRouter _appRouter;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(_authService);
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    await _authService.init();
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const CupertinoApp(
        home: Center(child: CupertinoActivityIndicator()),
      );
    }

    return CupertinoApp.router(
      title: 'Quasar',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      routerConfig: _appRouter.router,
    );
  }
}
