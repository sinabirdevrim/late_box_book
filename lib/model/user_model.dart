import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/model/base_model.dart';

import 'debt_model.dart';

class UserModel {
  String _providerId;
  String _uid;
  String _displayName;
  String _photoUrl;
  String _email;
  String _phoneNumber;
  DateTime _createdAt;
  DateTime _updatedAt;
  DebtModel _debtModel;
  bool _isMaster = false;
  String _pushToken;

  DateTime get createdAt => _createdAt;

  UserModel(
      [this._providerId,
      this._displayName,
      this._photoUrl,
      this._email,
      this._phoneNumber,
      this._uid]);

  String get phoneNumber => _phoneNumber;

  String get pushToken => _pushToken;

  set pushToken(String value) {
    _pushToken = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  bool get isMaster => _isMaster;

  set isMaster(bool value) {
    _isMaster = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get photoUrl {
    return _photoUrl != null
        ? _photoUrl
        : "https://i.stack.imgur.com/l60Hf.png";
  }

  set photoUrl(String value) {
    _photoUrl = value;
  }

  String get displayName => _displayName;

  set displayName(String value) {
    _displayName = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get providerId => _providerId;

  set providerId(String value) {
    _providerId = value;
  }

  DebtModel get debtModel => _debtModel;

  set debtModel(DebtModel value) {
    _debtModel = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': _uid,
      'email': _email,
      'userName': _displayName,
      'profilURL':
          _photoUrl == null ? "https://i.stack.imgur.com/l60Hf.png" : _photoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'debt': _debtModel == null ? new DebtModel().toMap() : _debtModel.toMap(),
      'isMaster': _isMaster,
      'pushToken': pushToken
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : _uid = map['userID'],
        _email = map['email'],
        _displayName = map['userName'],
        _photoUrl = map['profilURL'],
        _createdAt = (map['createdAt'] as Timestamp).toDate(),
        _updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        _debtModel =
            DebtModel.fromMap(new Map<String, dynamic>.from(map["debt"])),
        _isMaster = map['isMaster'],
        _pushToken = map['pushToken'];

  DateTime get updatedAt => _updatedAt;
}
