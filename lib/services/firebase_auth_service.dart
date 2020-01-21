import 'package:firebase_auth/firebase_auth.dart';
import 'package:late_box_book/model/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {}

  Future<UserModel> createUserWithEmailandPassword(
      String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserModel();
  }
}
