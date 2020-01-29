import 'package:cloud_firestore/cloud_firestore.dart';

class DebtModel {
  DateTime _createdAt;
  DateTime _updatedAt;
  double _value = 0;
  bool _isCreated = false;

  DebtModel();

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  DateTime get updatedAt => _updatedAt;

  double get value => _value;

  set value(double value) {
    _value = value;
  }

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  bool get isCreated => _isCreated;

  set isCreated(bool value) {
    _isCreated = value;
  }

  Map<String, dynamic> toMap() {
    if (!_isCreated) {
      return {
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'value': _value
      };
    } else {
      return {'updatedAt': FieldValue.serverTimestamp(), 'value': _value};
    }
  }

  DebtModel.fromMap(Map<String, dynamic> map)
      : _value = map['value'],
        _createdAt = (map['createdAt'] as Timestamp).toDate(),
        _updatedAt = (map['updatedAt'] as Timestamp).toDate();
}
