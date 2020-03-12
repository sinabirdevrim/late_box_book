import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserTeamModel {
  String _team;
  bool _isMaster;

  String get team => _team;

  set team(String value) {
    _team = value;
  }



  bool get isMaster => _isMaster;

  set isMaster(bool value) {
    _isMaster = value;
  }

  UserTeamModel.fromMap(Map<String, dynamic> map) {
    _team = map['team'];
    _isMaster = map['isMaster'];
  }
}
