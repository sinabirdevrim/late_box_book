import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoginUserEvent) {
      yield UserLoadingState();
      var result = await _userRepository.signInWithEmailAndPassword(
          event.userName, event.password);
      if (result.errorMessage.isNotEmpty) {
        yield UserErrorState(result.errorMessage);
      } else {
        yield UserLoadedState(result.data);
      }
    } else if (event is RegisterUserEvent) {
      yield UserLoadingState();
      var result = await _userRepository.createUserWithEmailAndPassword(
          event.userName, event.password);
      debugPrint(result.data.email);
      if (result.errorMessage.isNotEmpty) {
        yield UserErrorState(result.errorMessage);
      } else {
        yield UserLoadedState(result.data);
      }
    }
  }
}
