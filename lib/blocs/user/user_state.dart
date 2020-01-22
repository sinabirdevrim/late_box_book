import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserState extends Equatable {
  UserModel mUserModel;
}

class InitialUserState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  UserLoadedState(userModel) {
    super.mUserModel = userModel;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel];
}

class UserRegisterState extends UserState {
  UserRegisterState(userModel) {
    this.mUserModel = userModel;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel];
}

class UserErrorState extends UserState {
  String errorMessage;

  UserErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
