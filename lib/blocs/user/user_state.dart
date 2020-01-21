import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();
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
  UserModel userModel;

  UserLoadedState(this.userModel);

  @override
  // TODO: implement props
  List<Object> get props => [userModel];
}

class UserErrorState extends UserState {
  String errorMessage;

  UserErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
