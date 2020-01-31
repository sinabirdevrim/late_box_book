import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/base_model.dart';
import 'package:late_box_book/model/debt_model.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firestore_db_service.dart';

class UserRepository {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  final FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  Future<BaseModel<UserModel>> createUserWithEmailAndPassword(
      String email, String password, String nameAndSurname) async {
    return await _firebaseAuthService.createUserWithEmailAndPassword(
        email, password, nameAndSurname);
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

  Future<bool> createTeamName(String name, UserModel userModel) async {
    return await _firestoreDBService.createTeamName(name, userModel);
  }

  Future<bool> joinTeamName(String name, UserModel userModel) async {
    return await _firestoreDBService.joinTeamName(name, userModel);
  }

  Stream<List<UserModel>> getUserListForStream(String teamName) {
    return _firestoreDBService.getUserListForStream(teamName);
  }

  Future<bool> updateUserDebt(String name, String uid, DebtModel debtModel) async {
    return await _firestoreDBService.updateUserDebt(name, uid, debtModel);
  }
}
