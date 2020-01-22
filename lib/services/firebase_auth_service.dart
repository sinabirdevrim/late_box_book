import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/model/base_model.dart';
import 'package:late_box_book/model/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<BaseModel<UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    var response = BaseModel<UserModel>();
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if(result!=null){
        response.data = UserModel(result.user.providerId, result.user.displayName,
            result.user.photoUrl, result.user.email, result.user.phoneNumber);
      }else{
        response.errorMessage = "Hata";
      }
    } catch (e) {
      response.errorMessage = e.message.toString();
    }
    return response;
  }

  Future<BaseModel<UserModel>> createUserWithEmailAndPassword(
      String email, String password) async {
    var response = BaseModel<UserModel>();
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result != null) {
        response.data = UserModel(
            result.user.providerId,
            result.user.displayName,
            result.user.photoUrl,
            result.user.email,
            result.user.phoneNumber);
      } else {
        response.errorMessage = "Hata";
      }
    } catch (e) {
      response.errorMessage = e.message.toString();
    }
    return response;
  }
}
