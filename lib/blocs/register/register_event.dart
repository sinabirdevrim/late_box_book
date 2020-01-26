import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  String _userName, _password, _rePassword, _nameAndSurname;

  RegisterUserEvent(
      this._userName, this._password, this._rePassword, this._nameAndSurname);

  @override
  // TODO: implement props
  List<Object> get props => [_userName, _password, _rePassword,_nameAndSurname];

  String get password => _password;

  String get userName => _userName;

  get rePassword => _rePassword;

  get nameAndSurname => _nameAndSurname;


}
