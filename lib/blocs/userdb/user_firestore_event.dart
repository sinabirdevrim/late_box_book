import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserFirestoreEvent extends Equatable {
  List<UserModel> userModels;
}

class UserFirestoreCreateFireStoreEvent extends UserFirestoreEvent {
  String teamName, currencyType;
  DateTime dailyTime;

  UserFirestoreCreateFireStoreEvent(
      this.teamName, this.currencyType, this.dailyTime);

  @override
  // TODO: implement props
  List<Object> get props => [teamName, currencyType, dailyTime];
}

class UserFirestoreJoinFireStoreEvent extends UserFirestoreEvent {
  String teamName;

  UserFirestoreJoinFireStoreEvent(this.teamName);

  @override
  // TODO: implement props
  List<Object> get props => [teamName];
}

class UserFirestoreGetUsereEvent extends UserFirestoreEvent {
  String teamName;

  UserFirestoreGetUsereEvent([this.teamName]);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UserFirestoreUserUpdateEvent extends UserFirestoreEvent {
  @override
  // TODO: implement props
  List<Object> get props => [userModels];

  UserFirestoreUserUpdateEvent(List<UserModel> userModels) {
    super.userModels = userModels;
  }
}

class UserFirestoreUpdateDebtEvent extends UserFirestoreEvent {
  int totalDept = 0;
  int totalPayment = 0;
  String uid;

  UserFirestoreUpdateDebtEvent(this.totalDept, this.totalPayment, this.uid);

  @override
  // TODO: implement props
  List<Object> get props => [totalDept, totalPayment, uid];
}

class UserFirestoreSaveUserTokenEvent extends UserFirestoreEvent {
  String pushToken;

  UserFirestoreSaveUserTokenEvent(this.pushToken);

  @override
  // TODO: implement props
  List<Object> get props => [pushToken];
}
