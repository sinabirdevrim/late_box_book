import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:late_box_book/common/locator.dart';
import 'package:late_box_book/repository/user_repository.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoginUserEvent) {
      yield UserLoadingState();
      var test = await _userRepository.createUserWithEmailAndPassword(
          event.userName, event.password);
      yield UserLoadedState();
    }
  }
}
