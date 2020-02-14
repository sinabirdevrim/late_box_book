import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}


class LoginUserEvent extends LoginEvent {
  String _userName, _password;

  LoginUserEvent(this._userName, this._password);

  @override
  // TODO: implement props
  List<Object> get props => [_userName, _password];

  String get password => _password;

  String get userName => _userName;
}

class ForgotPasswordEvent extends LoginEvent{
  String email;

  ForgotPasswordEvent(this.email);

  @override
  // TODO: implement props
  List<Object> get props => [email];

}