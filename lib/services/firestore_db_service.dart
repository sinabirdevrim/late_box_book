import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/model/debt_model.dart';
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
      return true;
    } else {
      return false;
    }
  }

  Stream<List<UserModel>> getUserListForStream(String teamName) {
    return _firebaseDB
        .collection(FBConst.TEAM_COLLECTION)
        .document(teamName)
        .collection(FBConst.TEAM_USER)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => UserModel.fromMap(doc.data))
          .toList();
    });
  }

  Future<List<UserModel>> getUserList(String teamName) async {
    var userList = await _firebaseDB
        .collection(FBConst.TEAM_COLLECTION)
        .document(teamName)
        .collection(FBConst.TEAM_USER)
        .getDocuments();

    List<UserModel> list = [];
    for (DocumentSnapshot snap in userList.documents) {
      list.add(UserModel.fromMap(snap.data));
    }
    return list;
  }

  /// Update Debt
  Future<bool> updateUserDebt(
      String name, String uid, DebtModel debtModel) async {
    try {
      await _firebaseDB
          .collection(FBConst.TEAM_COLLECTION)
          .document(name)
          .collection(FBConst.TEAM_USER)
          .document(uid)
          .updateData({FBConst.FIELD_DEBT: debtModel.toMap()});
      return true;
    } catch (e) {
      return false;
    }
  }
}
