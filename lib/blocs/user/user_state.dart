import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserState extends Equatable {
  UserModel mUserModel;
}

class InitialUserState extends UserState {
  @override
  List<Object> get props => [];
}

class UserUnAuthenticatedState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UserAuthenticatedState extends UserState {
  UserAuthenticatedState(UserModel mUserModel) {
    super.mUserModel = mUserModel;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel];
}


class UserAuthenticatedErrorState extends UserState{
  String errorMessage;

  UserAuthenticatedErrorState(this.errorMessage);
  @override
  // TODO: implement props
  List<Object> get props => null;

}