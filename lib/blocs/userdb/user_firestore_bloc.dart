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
      yield* _mapGetUserState(_userBloc.userTeam);
    } else if (event is UserFirestoreUserUpdateEvent) {
      yield* _mapUserListUpdateToState(event.userModels, _userBloc.userTeam);
    } else if (event is UserFirestoreUpdateDebtEvent) {
      yield* _mapUpdateUserDeptState(event.totalDept, event.totalPayment,
          state.userModelList, event.uid, _userBloc.userTeam);
    } else if (event is UserFirestoreSaveUserTokenEvent) {
      yield* _mapGetUpdateUserPushToken(event.pushToken);
    }
  }

  Stream<UserFirestoreState> _mapGetUpdateUserPushToken(
      String pushToken) async* {
    await _userRepository.updateUserPushToken(
        pushToken, _userBloc.userTeam, _userBloc.state.mUserModel.uid);
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
    _userBloc.userTeam = teamName;
  }

  Stream<UserFirestoreState> _mapUpdateUserDeptState(
      int totalDept,
      int totalPayment,
      List<UserModel> userModels,
      String uid,
      String teamName) async* {
    var user = userModels.singleWhere((user) => user.uid == uid);
    user.debtModel.totalDept = totalDept;
    user.debtModel.totalPayment = totalPayment;
    await _userRepository.updateUserDebt(teamName, user.uid, user.debtModel);
    await _userRepository.sendPushNotification(user.pushToken, user.debtModel);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Stream<UserFirestoreState> _mapUserListUpdateToState(
      List<UserModel> _userModels, String teamName) async* {
    yield UserListFirestoreState(_userModels, teamName);
  }
}
