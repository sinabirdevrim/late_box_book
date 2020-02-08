import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class ProfileState extends Equatable {
  UserModel mUserModel;
}

class InitialProfileState extends ProfileState {
  InitialProfileState(UserModel userModel) {
    super.mUserModel = userModel;
  }

  @override
  List<Object> get props => [mUserModel];
}

class ProfileUpdateUserState extends ProfileState {
  UserModel mUserModel;

  ProfileUpdateUserState(UserModel userModel) {
    mUserModel = userModel;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel];
}
