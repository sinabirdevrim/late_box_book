import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:late_box_book/model/base_model.dart';

class UserModel {
  String _providerId;
  String _uid;
  String _displayName;
  String _photoUrl;
  String _email;
  String _phoneNumber;
  DateTime _createdAt;
  DateTime _updatedAt;

  DateTime get createdAt => _createdAt;

  UserModel(
      [this._providerId,
      this._displayName,
      this._photoUrl,
      this._email,
      this._phoneNumber,
      this._uid]);

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get photoUrl => _photoUrl;

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

  Map<String, dynamic> toMap() {
    return {
      'userID': _uid,
      'email': _email,
      'userName': _displayName,
      'profilURL': _photoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : _uid = map['userID'],
        _email = map['email'],
        _displayName = map['userName'],
        _photoUrl = map['profilURL'],
        _createdAt = (map['createdAt'] as Timestamp).toDate(),
        _updatedAt = (map['updatedAt'] as Timestamp).toDate();

  DateTime get updatedAt => _updatedAt;
}
