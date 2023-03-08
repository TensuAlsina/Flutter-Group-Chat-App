import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationAndAuthorizationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future authenticateUser(String userEmail, String userPassword) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future authorizeUser(String userEmail, String userPassword) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getCurrenUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user!;
    } catch (e) {
      rethrow;
    }
  }

  logUserOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {}
  }
}
