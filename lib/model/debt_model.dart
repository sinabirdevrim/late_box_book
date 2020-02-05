import 'package:cloud_firestore/cloud_firestore.dart';

class DebtModel {
  DateTime _createdAt;
  DateTime _updatedAt;
  int _totalDept = 0;
  int _totalPayment = 0;

  DebtModel();

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  DateTime get updatedAt => _updatedAt;

  int get totalDept => _totalDept;

  set totalDept(int value) {
    _totalDept = value;
  }

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  int get totalPayment => _totalPayment;

  set totalPayment(int value) {
    _totalPayment = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': _createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': _updatedAt ?? FieldValue.serverTimestamp(),
      'totalDept': _totalDept,
      'totalPayment': _totalPayment
    };
  }

  DebtModel.fromMap(Map<String, dynamic> map)
      : _createdAt = (map['createdAt'] as Timestamp).toDate(),
        _updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        _totalDept = map['totalDept'],
        _totalPayment = map['totalPayment'];
}
