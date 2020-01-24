import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class LoginState extends Equatable {
  UserModel mUserModel;
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}



class LoginLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginLoadedState extends LoginState {
  LoginLoadedState(userModel) {
    super.mUserModel = userModel;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel];
}

class LoginErrorState extends LoginState {
  String errorMessage;

  LoginErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
