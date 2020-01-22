import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoginUserEvent extends UserEvent {
  String _userName, _password;

  LoginUserEvent(this._userName, this._password);

  @override
  // TODO: implement props
  List<Object> get props => [_userName, _password];

  String get password => _password;

  String get userName => _userName;
}

class RegisterUserEvent extends UserEvent {
  String _userName, _password, _rePassword;

  RegisterUserEvent(this._userName, this._password, this._rePassword);

  @override
  // TODO: implement props
  List<Object> get props => [_userName, _password, _rePassword];

  String get password => _password;

  String get userName => _userName;

  get rePassword => _rePassword;


}
