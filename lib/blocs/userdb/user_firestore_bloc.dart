import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class UserFirestoreBloc extends Bloc<UserFirestoreEvent, UserFirestoreState> {
  UserBloc _userBloc;
  StreamSubscription _userSubscription;

  UserFirestoreBloc({@required UserBloc userBloc}) : assert(userBloc != null) {
    _userBloc = userBloc;
  }

  final UserRepository _userRepository = locator<UserRepository>();

  @override
  UserFirestoreState get initialState => InitialUserFirestoreState();

  @override
  Stream<UserFirestoreState> mapEventToState(UserFirestoreEvent event) async* {
    if (event is UserFirestoreCreateFireStoreEvent) {
      yield* _mapApUserCreateOrJoinFirestore(
          _userBloc.state.mUserModel, event.teamName, true);
    } else if (event is UserFirestoreJoinFireStoreEvent) {
      yield* _mapApUserCreateOrJoinFirestore(
          _userBloc.state.mUserModel, event.teamName, false);
    } else if (event is UserFirestoreGetUsereEvent) {
      yield* _mapGetUserState("test");
    } else if (event is UserFirestoreUserUpdateEvent) {
      yield* _mapUserListUpdateToState(event.userModels);
    }
  }

  Stream<UserFirestoreState> _mapGetUserState(String teamName) async* {
    _userSubscription?.cancel();
    _userSubscription = _userRepository
        .getUserListForStream(teamName)
        .listen((data) => add(UserFirestoreUserUpdateEvent(data)));
  }

  Stream<UserFirestoreState> _mapApUserCreateOrJoinFirestore(
      UserModel user, String teamName, bool isMaster) async* {
    user.isMaster = isMaster;
    if (isMaster) {
      await _userRepository.createTeamName(teamName, user);
    } else {
      await _userRepository.joinTeamName(teamName, user);
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Stream<UserFirestoreState> _mapUserListUpdateToState(
      List<UserModel> _userModels) async* {
    debugPrint("User Update oldu");
    yield UserListFirestoreState(_userModels);
  }
}
