import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';

class UserRepository {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuthService.createUserWithEmailandPassword(
        email, password);
  }
}
