import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/register/bloc.dart';
import 'package:late_box_book/blocs/user/user_bloc.dart';
import 'package:late_box_book/screens/register/register_form.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: BlocProvider(create: (_) => RegisterBloc(userBloc: BlocProvider.of<UserBloc>(context)), child: RegisterForm()),
    );
  }
}
