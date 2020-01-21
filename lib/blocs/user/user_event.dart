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
