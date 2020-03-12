import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/common/shared_pref_manager.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/model/user_team.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  String userTeam;

  final UserRepository _userRepository = locator<UserRepository>();
  final SharedPrefManager _sharedPrefManager = locator<SharedPrefManager>();

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserIsLoginEvent) {
      yield* _mapAppUserIsLoginState();
    } else if (event is UserLogOutEvent) {
      yield* _mapAppUserLogOut();
    } else if (event is UserLoginEvent) {
      yield* _mapAppUserLogIn(event.mUserModel, event.isNewUser);
    }
  }

  Stream<UserState> _mapAppUserIsLoginState() async* {
    var result = await _userRepository.userIsAuthenticated();
    if (result.errorMessage.isNotEmpty) {
      yield UserAuthenticatedErrorState(result.errorMessage);
    } else {
      if (result.data != null) {
        var teams = await _userRepository.getUserTeam(result.data.uid);
        _setUserTeam(teams);
        yield UserAuthenticatedState(result.data, false);
      } else {
        yield UserUnAuthenticatedState();
      }
    }
  }

  void _setUserTeam(List<UserTeamModel> teams) {
    var currentTeam = _sharedPrefManager.getTeam();
    userTeam =
        teams.firstWhere((t) => t.team == currentTeam, orElse: () => teams.first).team;
  }

  Stream<UserState> _mapAppUserLogOut() async* {
    await _userRepository.signOut();
    yield UserUnAuthenticatedState();
  }

  Stream<UserState> _mapAppUserLogIn(UserModel user, bool isNewUser) async* {
    if (!isNewUser) {
      var result = await _userRepository.getUserTeam(user.uid);
      if (result != null && result.isNotEmpty) {
        _setUserTeam(result);
      }
    }
    yield UserAuthenticatedState(user, isNewUser);
  }
}
