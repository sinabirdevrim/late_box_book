import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserBloc _userBloc;

  RegisterBloc({@required UserBloc userBloc}) : assert(userBloc != null) {
    _userBloc = userBloc;
  }

  final UserRepository _userRepository = locator<UserRepository>();

  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterUserEvent) {
      yield RegisterLoadingState();
      var result = await _userRepository.createUserWithEmailAndPassword(
          event.userName, event.password, event.nameAndSurname);
      if (result.errorMessage.isNotEmpty) {
        yield RegisterErrorState(result.errorMessage);
      } else {
       _userBloc.add(UserLoginEvent(result.data, true));
       yield RegisterLoadedState(result.data);
      }
    }
  }
}
