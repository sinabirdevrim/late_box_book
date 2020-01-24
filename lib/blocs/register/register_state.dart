import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class RegisterState extends Equatable {
  UserModel mUserModel;
}

class InitialRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterLoadedState extends RegisterState {
  RegisterLoadedState(userModel) {
    super.mUserModel = userModel;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mUserModel];
}

class RegisterErrorState extends RegisterState {
  String errorMessage;

  RegisterErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
