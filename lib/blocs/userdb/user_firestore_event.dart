import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserFirestoreEvent extends Equatable {
  const UserFirestoreEvent();
}

class UserFirestoreCreateFireStoreEvent extends UserFirestoreEvent {
  String teamName;

  UserFirestoreCreateFireStoreEvent(this.teamName);

  @override
  // TODO: implement props
  List<Object> get props => [teamName];
}

class UserFirestoreJoinFireStoreEvent extends UserFirestoreEvent {
  String teamName;

  UserFirestoreJoinFireStoreEvent(this.teamName);

  @override
  // TODO: implement props
  List<Object> get props => [teamName];
}

class UserFirestoreGetUsereEvent extends UserFirestoreEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UserFirestoreUserUpdateEvent extends UserFirestoreEvent {
  List<UserModel> userModels;

  @override
  // TODO: implement props
  List<Object> get props => null;

  UserFirestoreUserUpdateEvent(this.userModels);
}
