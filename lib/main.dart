import 'package:flutter/material.dart';
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
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp.router(
      title: 'Quasar',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeData.light().scaffoldBackgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      routerConfig: _appRouter.router,
    );
  }
}
