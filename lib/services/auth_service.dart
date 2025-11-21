import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Platform.isIOS
        ? '445075180949-dqa2u0j3n15jrodjdt5l4mjpt6kcgqim.apps.googleusercontent.com'
        : null,
    scopes: ['email', 'profile'],
  );

  GoogleSignInAccount? _currentUser;

  GoogleSignInAccount? get currentUser => _currentUser;

  bool get isSignedIn => _currentUser != null;

  String get userName => _currentUser?.displayName ?? '';

  String get userEmail => _currentUser?.email ?? '';

  String get userPhotoUrl => _currentUser?.photoUrl ?? '';

  Future<void> init() async {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      _currentUser = account;
    });

    await _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _currentUser = account;
      return account;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _currentUser = null;
  }

  Future<Map<String, String?>> getTokens() async {
    if (_currentUser == null) {
      throw Exception('No user signed in');
    }

    final GoogleSignInAuthentication auth = await _currentUser!.authentication;
    return {'idToken': auth.idToken, 'accessToken': auth.accessToken};
  }
}
