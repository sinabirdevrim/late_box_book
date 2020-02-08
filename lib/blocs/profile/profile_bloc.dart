import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:late_box_book/blocs/user/user_bloc.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserBloc _userBloc;
  final UserRepository _userRepository = locator<UserRepository>();

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
    } else if (event is ProfileInitEvent) {
      yield ProfileUpdateUserState(_userBloc.state.mUserModel);
    }
  }

  Stream<ProfileState> _mapUpdateUserPhoto(File userPhoto) async* {
    var result = await _userRepository.uploadFile(
        _userBloc.state.mUserModel.uid, "profil_foto", userPhoto);
    if (result != null) {
      var user = await _userRepository.updateProfilePhoto(
          result, _userBloc.userTeam, _userBloc.state.mUserModel.uid);
      _userBloc.state.mUserModel = user.data;
      yield ProfileUpdateUserState(_userBloc.state.mUserModel);
    }
  }
}
