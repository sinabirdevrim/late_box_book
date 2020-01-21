import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormCard extends StatefulWidget {
  Function(String _email) funcEmail;
  Function(String _password) funcPassword;
  GlobalKey<FormState> _formKey;

  LoginFormCard(this.funcEmail,this.funcPassword, this._formKey);

  @override
  _LoginFormCardState createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(490),
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
          key: widget._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Login",
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
                  widget.funcEmail(value);
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
                  widget.funcPassword(value);
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil.getInstance().setSp(28)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
