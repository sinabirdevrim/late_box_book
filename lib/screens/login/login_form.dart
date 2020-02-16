import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/login/bloc.dart';
import 'package:late_box_book/blocs/login/login_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/customwidget/platform_specific_alert_dialog.dart';
import 'package:late_box_book/screens/register/register_screen.dart';
import 'package:late_box_book/widgets/login/bottomsheet/forgot_password_bottom_sheet.dart';
import 'package:late_box_book/widgets/login/login_form_card.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener(
          bloc: _loginBloc,
          listener: (context, state) {
            if (state is LoginErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                PlatformSpecificAlertDialog(
                  header: "Login Error",
                  title: state.errorMessage,
                  doneText: 'Done',
                ).show(context);
              });
            } else if (state is LoginLoadedState) {
              BlocProvider.of<UserBloc>(context)
                  .add(UserLoginEvent(state.mUserModel, false));
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 50.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text("LateBox\nBook",
                          style: TextStyle(
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        "assets/login2.png",
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                LoginFormCard(
                    (_email) {
                      this._email = _email;
                    },
                    (_password) {
                      this._password = _password;
                    },
                    _formKey,
                    (onForgotPasswordClick) {
                      showForgotPasswordBottomSheet(context);
                    }),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BlocBuilder(
                      bloc: _loginBloc,
                      builder: (_, LoginState state) {
                        return Expanded(
                          child: InkWell(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF17ead9),
                                    Color(0xFF6078ea)
                                  ]),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _formSubmit(_loginBloc);
                                  },
                                  child: Center(
                                    child: loginBtn(state),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
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
          )),
    );
  }

  Widget loginBtn(LoginState state) {
    if (state is LoginLoadingState) {
      return CircularProgressIndicator();
    } else {
      return Text("Sign in",
          style:
              TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1.0));
    }
  }

  void showForgotPasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ForgotPasswordForm((email) {
                    _loginBloc.add(ForgotPasswordEvent(email));
                    Navigator.pop(context);
                  })));
        });
  }

  _formSubmit(LoginBloc loginBloc) {
    if (!(loginBloc.state is LoginLoadingState)) {
      _formKey.currentState.save();
      loginBloc.add(LoginUserEvent(_email, _password));
    }
  }
}
