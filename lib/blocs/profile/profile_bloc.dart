import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:late_box_book/blocs/user/user_bloc.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/user_dept.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserBloc _userBloc;
  final UserRepository _userRepository = locator<UserRepository>();

  StreamSubscription _userProfileSubscription;

  ProfileBloc({@required UserBloc userBloc})
      : assert(userBloc != null),
        _userBloc = userBloc;

  @override
  ProfileState get initialState =>
      InitialProfileState(_userBloc.state.mUserModel);

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileUpdateImageEvent) {
      yield* _mapUpdateUserPhoto(event.userFile);
    } else if (event is ProfileUpdateUserInfoEvent) {
      yield ProfileUpdateUserState(event.mUserModel, event.totalDept,
          event.totalPayment, event.userDebts,event.teamCount);
    } else if (event is ProfileGetUserEvent) {
      yield* _mapGetUserInfos(_userBloc.state.mUserModel.uid);
    }
  }

  Stream<ProfileState> _mapUpdateUserPhoto(File userPhoto) async* {
    var result = await _userRepository.uploadFile(
        _userBloc.state.mUserModel.uid, "profil_foto", userPhoto);
    if (result != null) {
      await _userRepository.updateProfilePhoto(
          result, _userBloc.userTeam, _userBloc.state.mUserModel.uid);
      _userBloc.state.mUserModel.photoUrl = result;
      yield ProfileUpdateUserState(_userBloc.state.mUserModel, state.totalDept,
          state.totalPaymnet, state.userDebts,state.teamCount);
    }
  }

  Stream<ProfileState> _mapGetUserInfos(String uid) async* {
    _userProfileSubscription?.cancel();
    _userProfileSubscription =
        _userRepository.getUserAllDebtTeam(uid).listen((data) {
      calculateUserDebt(data);
    });
  }

  void calculateUserDebt(List<UserDebt> userDebtList) {
    int totalDept = 0;
    int totalPayment = 0;
    int teamCount=0;
    for (UserDebt value in userDebtList) {
      totalDept += value.totalDebt;
      totalPayment += value.totalPayment;
      teamCount++;
    }
    add(ProfileUpdateUserInfoEvent(
        _userBloc.state.mUserModel, userDebtList, totalDept, totalPayment,teamCount));
  }

  @override
  Future<void> close() {
    _userProfileSubscription?.cancel();
    return super.close();
  }
}
