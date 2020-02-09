import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_dept.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileUpdateImageEvent extends ProfileEvent {
  File userFile;

  ProfileUpdateImageEvent(this.userFile);

  @override
  // TODO: implement props
  List<Object> get props => [userFile];
}

class ProfileUpdateUserInfoEvent extends ProfileEvent {
  UserModel mUserModel;
  List<UserDebt> userDebts;
  int totalDept;
  int totalPayment;
  int teamCount;

  ProfileUpdateUserInfoEvent(
      this.mUserModel, this.userDebts, this.totalDept, this.totalPayment,this.teamCount);

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel, userDebts, totalDept, totalPayment,teamCount];
}

class ProfileGetUserEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
