import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/model/base_model.dart';
import 'package:late_box_book/model/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<BaseModel<UserModel>> signInWithEmailAndPassword(String email,
      String password) async {
    var response = BaseModel<UserModel>();
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint(result.toString());
      if (result != null) {
        response.data = UserModel(
            result.user.providerId,
            result.user.displayName,
            result.user.photoUrl,
            result.user.email,
            result.user.phoneNumber,
            result.user.uid);
      } else {
        response.errorMessage = "Hata";
      }
    } catch (e) {
      response.errorMessage = e.message.toString();
    }
    return response;
  }

  Future<BaseModel<UserModel>> createUserWithEmailAndPassword(String email,
      String password, String nameAndSurname) async {
    var response = BaseModel<UserModel>();
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result != null) {
        var user = UserUpdateInfo();
        user.displayName = nameAndSurname;
        await result.user.updateProfile(user);
        await result.user.reload();
        response.data = UserModel(
            result.user.providerId,
            nameAndSurname,
            result.user.photoUrl,
            result.user.email,
            result.user.phoneNumber,
            result.user.uid);
      } else {
        response.errorMessage = "Hata";
      }
    } catch (e) {
      response.errorMessage = e.message.toString();
    }
    return response;
  }

  Future<BaseModel<UserModel>> userIsAuthenticated() async {
    var response = BaseModel<UserModel>();
    try {
      var result = await _firebaseAuth.currentUser();
      if (result != null) {
        response.data = UserModel(result.providerId, result.displayName,
            result.photoUrl, result.email, result.phoneNumber, result.uid);
      }
    } catch (e) {
      response.errorMessage = e.message.toString();
    }
    return response;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
