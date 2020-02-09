import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_dept.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class ProfileState extends Equatable {
  UserModel mUserModel;
  int totalDept = 0;
  int totalPaymnet = 0;
  List<UserDebt> userDebts = List<UserDebt>();
  int teamCount = 0;
}

class InitialProfileState extends ProfileState {
  InitialProfileState(UserModel userModel) {
    super.mUserModel = userModel;
  }

  @override
  List<Object> get props => [mUserModel];
}

class ProfileUpdateUserState extends ProfileState {
  ProfileUpdateUserState(UserModel userModel, int mTotalDept, int mTotalPayment,
      List<UserDebt> mUserDebts, int mTeamCount) {
    mUserModel = userModel;
    totalDept = mTotalDept;
    totalPaymnet = mTotalPayment;
    userDebts.clear();
    userDebts.addAll(mUserDebts);
    teamCount = mTeamCount;
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [mUserModel, totalDept, totalPaymnet, userDebts, teamCount];
}
