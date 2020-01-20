import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:late_box_book/screens/register.dart';
import 'package:late_box_book/widgets/login/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

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
                    child: Text("LateBox\nBook",
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
              LoginFormCard((_email, _password) {
                _loginUser(_email, _password);
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
                            gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
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
                              _formSubmit();
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
  }

  _formSubmit() {
    _formKey.currentState.save();
  }

  _loginUser(String email, String password) {
    //Bloc gidicek
  }
}
