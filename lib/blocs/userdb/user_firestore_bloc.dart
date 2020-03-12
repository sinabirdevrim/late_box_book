import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/common/schedule_notification.dart';
import 'package:late_box_book/common/shared_pref_manager.dart';
import 'package:late_box_book/model/debt_model.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class UserFirestoreBloc extends Bloc<UserFirestoreEvent, UserFirestoreState> {
  UserBloc _userBloc;
  StreamSubscription _userSubscription;

  final SharedPrefManager _sharedPrefManager = locator<SharedPrefManager>();

  UserFirestoreBloc({@required UserBloc userBloc}) : assert(userBloc != null) {
    _userBloc = userBloc;
  }

  final UserRepository _userRepository = locator<UserRepository>();

  @override
  UserFirestoreState get initialState => InitialUserFirestoreState();

  @override
  Stream<UserFirestoreState> mapEventToState(UserFirestoreEvent event) async* {
    if (event is UserFirestoreCreateFireStoreEvent) {
      yield* _mapApUserCreateOrJoinFirestore(_userBloc.state.mUserModel,
          event.teamName, true, event.currencyType, event.dailyTime);
    } else if (event is UserFirestoreJoinFireStoreEvent) {
      yield* _mapApUserCreateOrJoinFirestore(
          _userBloc.state.mUserModel, event.teamName, false);
    } else if (event is UserFirestoreGetUsereEvent) {
      if (event.teamName != null) {
        _sharedPrefManager.setTeam(event.teamName);
        _userBloc.userTeam = event.teamName;
        yield* _mapGetUserState(event.teamName);
      } else {
        yield* _mapGetUserState(_userBloc.userTeam);
      }
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
      UserModel user, String teamName, bool isMaster,
      [String currencyType, DateTime dailyTime]) async* {
    user.isMaster = isMaster;
    if (isMaster && currencyType != null && currencyType.isNotEmpty) {
      user.debtModel = DebtModel();
      user.debtModel.currencyType = currencyType;
      user.dailyTime = dailyTime;
    }
    if (isMaster) {
      await _userRepository.createTeamName(teamName, user);
    } else {
      await _userRepository.joinTeamName(teamName, user);
    }
    _userBloc.userTeam = teamName;
    _sharedPrefManager.setTeam(teamName);
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
    user.debtModel.updatedAt = DateTime.now();
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
    if (_userModels == null ||
        _userModels.length == 0 ||
        teamName == null ||
        teamName.isEmpty) {
      yield UserEmptyFirestoreState();
    } else {
      var teamDailyTime = _userModels.where((t) => t.isMaster).first.dailyTime;
      if (teamDailyTime != null) {
        ScheduleNotificationManager().dailyNotification(Time(
            teamDailyTime.hour, teamDailyTime.minute, teamDailyTime.second));
      }
      yield UserListFirestoreState(_userModels, teamName);
    }
  }
}
