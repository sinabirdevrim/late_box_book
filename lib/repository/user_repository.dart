import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/base_model.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';

class UserRepository {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  Future<BaseModel<UserModel>> createUserWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuthService.createUserWithEmailAndPassword(
        email, password);
  }

  Future<BaseModel<UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuthService.signInWithEmailAndPassword(
        email, password);
  }

  Future<BaseModel<UserModel>> userIsAuthenticated() async {
    return await _firebaseAuthService.userIsAuthenticated();
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }
}
