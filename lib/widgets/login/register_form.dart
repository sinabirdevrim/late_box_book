import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterFormCard extends StatefulWidget {
  @override
  _RegisterFormCardState createState() => _RegisterFormCardState();
}

class _RegisterFormCardState extends State<RegisterFormCard> {
  @override
  Widget build(BuildContext context) {
    String _email, _password, _passwordRepat;
    final _formKey = GlobalKey<FormState>();

    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(600),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Register",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      letterSpacing: .6)),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Username",
                  style:
                      TextStyle(fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    hintText: "username",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onSaved: (String value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("PassWord",
                  style:
                      TextStyle(fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onSaved: (String value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("RePassWord",
                  style:
                      TextStyle(fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "RePassword",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onSaved: (String value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
