import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserIsLoginEvent) {
      yield* _mapAppUserIsLoginState();
    } else if (event is UserLogOutEvent) {
      yield* _mapAppUserLogOut();
    } else if (event is UserLoginEvent) {
      yield* _mapAppUserLogIn(state.mUserModel);
    }
  }

  Stream<UserState> _mapAppUserIsLoginState() async* {
    var result = await _userRepository.userIsAuthenticated();
    if (result.errorMessage.isNotEmpty) {
      yield UserAuthenticatedErrorState(result.errorMessage);
    } else {
      if (result.data != null) {
        yield UserAuthenticatedState(result.data);
      } else {
        yield UserUnAuthenticatedState();
      }
    }
  }

  Stream<UserState> _mapAppUserLogOut() async* {
    await _userRepository.signOut();
    yield UserUnAuthenticatedState();
  }

  Stream<UserState> _mapAppUserLogIn(UserModel user) async* {
    yield UserAuthenticatedState(user);
  }
}
