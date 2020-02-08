import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileInitEvent extends ProfileEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class ProfileUpdateImageEvent extends ProfileEvent {
  File userFile;

  ProfileUpdateImageEvent(this.userFile);

  @override
  // TODO: implement props
  List<Object> get props => [userFile];
}
