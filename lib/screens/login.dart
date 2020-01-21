import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/screens/register.dart';
import 'package:late_box_book/widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    final _userBloc = BlocProvider.of<UserBloc>(context);
    String test="Not Login";

    return BlocBuilder(
      bloc: _userBloc,
      builder: (_, UserState state) {
        if(state is UserLoadedState){
          test = state.userModel.email;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 50.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text("LateBox\nBook $test",
                            style: TextStyle(
                                letterSpacing: .6,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil.getInstance().setSp(45))),
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          "assets/login2.jpg",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  LoginFormCard((_email) {
                    this._email = _email;
                  }, (_password) {
                    this._password = _password;
                  }, _formKey),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  _formSubmit(_userBloc);
                                },
                                child: Center(
                                  child: Text("SignIn",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User? ",
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text("Register",
                            style: TextStyle(
                              color: Color(0xFF5d74e3),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _formSubmit(UserBloc userBloc) {
    _formKey.currentState.save();
    userBloc.add(LoginUserEvent(_email, _password));
  }
}
