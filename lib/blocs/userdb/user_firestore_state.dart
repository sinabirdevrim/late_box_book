import 'package:equatable/equatable.dart';
import 'package:late_box_book/model/user_model.dart';

abstract class UserFirestoreState extends Equatable {
  const UserFirestoreState();
}

class InitialUserFirestoreState extends UserFirestoreState {
  @override
  List<Object> get props => [];
}


class UserCreatedFirestoreState extends UserFirestoreState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UserListFirestoreState extends UserFirestoreState {
  List<UserModel> userModelList;

  UserListFirestoreState(this.userModelList);

  @override
  // TODO: implement props
  List<Object> get props => [userModelList];
}

