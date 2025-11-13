import 'package:flutter/cupertino.dart';
import 'screens/event_list_page.dart';
import 'screens/login_page.dart';
import 'services/auth_service.dart';

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
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
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
    return CupertinoApp(
      title: 'Quasar',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: !_isInitialized
          ? const Center(child: CupertinoActivityIndicator())
          : _authService.isSignedIn
              ? const EventListPage()
              : LoginPage(authService: _authService),
      routes: {
        '/home': (context) => const EventListPage(),
        '/login': (context) => LoginPage(authService: _authService),
      },
    );
  }
}
