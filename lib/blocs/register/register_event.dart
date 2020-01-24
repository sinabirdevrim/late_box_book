import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}
class RegisterUserEvent extends RegisterEvent {
  String _userName, _password, _rePassword;

  RegisterUserEvent(this._userName, this._password, this._rePassword);

  @override
  // TODO: implement props
  List<Object> get props => [_userName, _password, _rePassword];

  String get password => _password;

  String get userName => _userName;

  get rePassword => _rePassword;


}