import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/blocs/user/user_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: BlocBuilder(
        bloc: _userBloc,
        builder: (_, UserState state) {
          return Center(
              child: RaisedButton(
            child: Text("LogOut"),
            onPressed: () {
              _userBloc.add(UserLogOutEvent());
            },
          ));
        },
      ),
    );
  }
}
