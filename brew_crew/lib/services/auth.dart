import 'package:brew_crew/models/custom_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CustomUser? _userFromUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<CustomUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromUser(user!));
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromUser(user!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return _userFromUser(user!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPass(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService(uid: user?.uid)
          .updateUserData("0", "New Crew Member", 100);
      return _userFromUser(user!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
