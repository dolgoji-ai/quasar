import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  GoogleSignInAccount? _currentUser;

  GoogleSignInAccount? get currentUser => _currentUser;

  User? get firebaseUser => _firebaseAuth.currentUser;

  bool get isSignedIn => _firebaseAuth.currentUser != null;

  String get userName =>
      _firebaseAuth.currentUser?.displayName ?? _currentUser?.displayName ?? '';

  String get userEmail =>
      _firebaseAuth.currentUser?.email ?? _currentUser?.email ?? '';

  String get userPhotoUrl =>
      _firebaseAuth.currentUser?.photoURL ?? _currentUser?.photoUrl ?? '';

  Future<void> init() async {
    _googleSignIn.onCurrentUserChanged.listen((account) async {
      _currentUser = account;
      if (account != null) {
        await _signInWithFirebase(account);
      }
    });

    await _googleSignIn.signInSilently();
  }

  Future<void> _signInWithFirebase(GoogleSignInAccount googleUser) async {
    try {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _currentUser = account;
      if (account != null) {
        await _signInWithFirebase(account);
      }
      return account;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
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
