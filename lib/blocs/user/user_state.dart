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
  bool mIsNewUser;

  UserAuthenticatedState(UserModel mUserModel, bool isNewUser) {
    super.mUserModel = mUserModel;
    this.mIsNewUser = isNewUser;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel,mIsNewUser];
}

class UserAuthenticatedErrorState extends UserState {
  String errorMessage;

  UserAuthenticatedErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];
}
