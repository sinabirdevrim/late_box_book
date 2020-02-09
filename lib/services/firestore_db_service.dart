import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/model/base_model.dart';
import 'package:late_box_book/model/debt_model.dart';
import 'package:late_box_book/model/user_dept.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/services/fb_const.dart';

class FirestoreDBService {
  final Firestore _firebaseDB = Firestore.instance;

  /// Create Team
  Future<bool> createTeamName(String name, UserModel userModel) async {
    var teams = await _firebaseDB
        .collection(FBConst.TEAM_COLLECTION)
        .where(FBConst.TEAM_NAME, isEqualTo: name)
        .getDocuments();
    if (teams.documents == null || teams.documents.length == 0) {
      await _firebaseDB
          .collection(FBConst.TEAM_COLLECTION)
          .document(name)
          .collection(FBConst.TEAM_USER)
          .document(userModel.uid)
          .setData(userModel.toMap());
      createTeamUserName(userModel, name);
      return true;
    } else {
      return false;
    }
  }

  /// Create Team User
  Future<bool> createTeamUserName(UserModel userModel, String team) async {
    if (userModel != null) {
      await _firebaseDB
          .collection(FBConst.TEAM_USER_COLLECTION)
          .document(userModel.uid)
          .collection(FBConst.TEAM_COLLECTION)
          .document(team)
          .setData({
        "team": team,
        "isMaster": userModel.isMaster,
        "totalDebt": 0,
        "totalPayment": 0
      });
      return true;
    } else {
      return false;
    }
  }

  /// Join Team
  Future<bool> joinTeamName(String name, UserModel userModel) async {
    var teams = await _firebaseDB
        .collection(FBConst.TEAM_COLLECTION)
        .where(FBConst.TEAM_NAME, isEqualTo: name)
        .getDocuments();
    if (teams.documents != null || teams.documents.length != 0) {
      await _firebaseDB
          .collection(FBConst.TEAM_COLLECTION)
          .document(name)
          .collection(FBConst.TEAM_USER)
          .document(userModel.uid)
          .setData(userModel.toMap());
      createTeamUserName(userModel, name);
      return true;
    } else {
      return false;
    }
  }

  Future<List<String>> getUserTeam(String uid) async {
    try {
      var data = await _firebaseDB
          .collection(FBConst.TEAM_USER_COLLECTION)
          .document(uid)
          .collection(FBConst.TEAM_COLLECTION)
          .getDocuments();
      return data.documentChanges
          .map((t) => t.document.data["team"].toString())
          .toList();
    } catch (e) {
      debugPrint("Hata: " + e.toString());
      return List<String>();
    }
  }

  Stream<List<UserModel>> getUserListForStream(String teamName) {
    return _firebaseDB
        .collection(FBConst.TEAM_COLLECTION)
        .document(teamName)
        .collection(FBConst.TEAM_USER)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) {
        debugPrint(doc.data.toString());
        return UserModel.fromMap(doc.data);
      }).toList();
    });
  }

  /// Update Debt
  Future<bool> updateUserDebt(
      String name, String uid, DebtModel debtModel) async {
    try {
      getUserAllDebtTeam(uid);
      await _firebaseDB
          .collection(FBConst.TEAM_COLLECTION)
          .document(name)
          .collection(FBConst.TEAM_USER)
          .document(uid)
          .updateData({FBConst.FIELD_DEBT: debtModel.toMap()});
      _firebaseDB
          .collection(FBConst.TEAM_USER_COLLECTION)
          .document(uid)
          .collection(FBConst.TEAM_COLLECTION)
          .document(name)
          .updateData({
        "totalDebt": debtModel.totalDept,
        "totalPayment": debtModel.totalPayment
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserPushToken(
      String pushToken, String teamName, String uId) async {
    try {
      _firebaseDB
          .collection(FBConst.TEAM_COLLECTION)
          .document(teamName)
          .collection(FBConst.TEAM_USER)
          .document(uId)
          .updateData({FBConst.TEAM_USER_PUSH_TOKEN: pushToken});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProfilePhoto(
      String userID, String photoUrl, String team) async {
    await _firebaseDB
        .collection(FBConst.TEAM_COLLECTION)
        .document(team)
        .collection(FBConst.TEAM_USER)
        .document(userID)
        .updateData({'profilURL': photoUrl});
    return true;
  }

  Stream<List<UserDebt>> getUserAllDebtTeam(String uid) {
    return _firebaseDB
        .collection(FBConst.TEAM_USER_COLLECTION)
        .document(uid)
        .collection(FBConst.TEAM_COLLECTION)
        .snapshots()
        .map((data) {
      return data.documents.map((t) => UserDebt.fromMap(t.data)).toList();
    });
  }
}
