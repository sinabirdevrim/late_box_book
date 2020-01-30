import 'package:equatable/equatable.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserEvent extends Equatable {
  UserModel mUserModel;
}

class UserIsLoginEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UserLogOutEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UserLoginEvent extends UserEvent {
  bool isNewUser;
  UserLoginEvent(mUserModel, this.isNewUser) {
    super.mUserModel = mUserModel;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel];
}
