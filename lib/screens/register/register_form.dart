import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/register/bloc.dart';
import 'package:late_box_book/customwidget/platform_specific_alert_dialog.dart';
import 'package:late_box_book/widgets/login/register_form_card.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String _email, _password, _rePassword;
  final _formKey = GlobalKey<FormState>();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener(
        bloc: _registerBloc,
        listener: (context, state) {
          if (state is RegisterErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              PlatformSpecificAlertDialog(
                header: "Register Error",
                title: state.errorMessage,
                doneText: 'Done',
              ).show(context);
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 28),
          child: Column(
            children: <Widget>[
              RegisterFormCard((_mEmail) {
                _email = _mEmail;
              }, (_mPassword) {
                _password = _mPassword;
              }, (_mRepassword) {
                _rePassword = _mRepassword;
              }, _formKey),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BlocBuilder(
                    bloc: _registerBloc,
                    builder: (_, RegisterState state) {
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
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  _formSubmit(_registerBloc);
                                },
                                child: Center(
                                  child: registerBtn(state),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget registerBtn(RegisterState state) {
    debugPrint(state.toString());
    if (state is RegisterLoadingState) {
      return CircularProgressIndicator();
    } else {
      return Text("Register",
          style:
              TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1.0));
    }
  }

  void _formSubmit(RegisterBloc userBloc) {
    if (!(userBloc.state is RegisterLoadingState)) {
      _formKey.currentState.save();
      userBloc.add(RegisterUserEvent(_email, _password, _rePassword));
    }
  }
}
