import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserFirestoreState extends Equatable {
  List<UserModel> userModelList;
}

class InitialUserFirestoreState extends UserFirestoreState {
  @override
  List<Object> get props => [];
}

class UserCreatedFirestoreState extends UserFirestoreState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UserListFirestoreState extends UserFirestoreState {
  int totalDebt = 0;
  int totalPayment = 0;
  double percent = 0.0;
  String teamName="";

  UserListFirestoreState(List<UserModel> userModelList,this.teamName) {
    super.userModelList = userModelList;
    calculateForDebt();
  }

  calculateForDebt() {
    for (UserModel values in userModelList) {
      totalDebt += values.debtModel.totalDept;
      totalPayment += values.debtModel.totalPayment;
    }
    if (totalDebt != 0) {
    percent = ((totalPayment * 100) / totalDebt).toDouble();
    }
  }

  @override
  // TODO: implement props
  List<Object> get props => [userModelList];
}
