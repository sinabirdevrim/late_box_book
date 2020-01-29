import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserEvent) {
      yield LoginLoadingState();
      var result = await _userRepository.signInWithEmailAndPassword(
          event.userName, event.password);
      if (result.errorMessage.isNotEmpty) {
        yield LoginErrorState(result.errorMessage);
      } else {
        yield LoginLoadedState(result.data);
      }
    }
  }
}
