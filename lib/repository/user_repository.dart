import 'dart:io';

import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/base_model.dart';
import 'package:late_box_book/model/debt_model.dart';
import 'package:late_box_book/model/user_dept.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firebase_auth_service.dart';
import 'package:late_box_book/services/firebase_storage_service.dart';
import 'package:late_box_book/services/firestore_db_service.dart';
import 'package:late_box_book/services/notification_service.dart';

class UserRepository {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  final FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  final NotificationService _notificationService =
      locator<NotificationService>();

  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();

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

  Future<bool> updateUserDebt(
      String name, String uid, DebtModel debtModel) async {
    return await _firestoreDBService.updateUserDebt(name, uid, debtModel);
  }

  Future<bool> sendPushNotification(
      String pushToken, DebtModel debtModel) async {
    return await _notificationService.sendNotification(
        pushToken,
        "Update Your Debt",
        "Total Debt: ${debtModel.totalDept} TL, Total Payment: ${debtModel.totalPayment} TL");
  }

  Future<String> uploadFile(
      String userID, String fileType, File uploadFile) async {
    return await _firebaseStorageService.uploadFile(
        userID, fileType, uploadFile);
  }

  Future<List<String>> getUserTeam(String uid) async {
    return await _firestoreDBService.getUserTeam(uid);
  }

  Future<bool> updateUserPushToken(
      String pushToken, String teamName, String uID) async {
    return await _firestoreDBService.updateUserPushToken(
        pushToken, teamName, uID);
  }

  Future<BaseModel<UserModel>> updateProfilePhoto(
      String photoUrl, String team, String uid) async {
    await _firestoreDBService.updateProfilePhoto(uid, photoUrl, team);
    return await _firebaseAuthService.updateUserProfile(photoUrl);
  }

  Stream<List<UserDebt>> getUserAllDebtTeam(String uid) {
    return _firestoreDBService.getUserAllDebtTeam(uid);
  }

  Future<bool> forgotPassword(String email) async {
    return _firebaseAuthService.forgotPassword(email);
  }
}
