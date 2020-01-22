import 'package:flutter/material.dart';
import 'package:late_box_book/customwidget/lb_text_form.dart';

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
      height: 300,
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
                      fontSize: 25,
                      letterSpacing: .6)),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                hintText: "Username",
                onSaved: (String value) {
                  _email = value;
                },
                labelText: "username",
              ),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                obscureText: true,
                hintText: "Password",
                onSaved: (String value) {
                  _password = value;
                },
                labelText: "PassWord",
              ),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                obscureText: true,
                hintText: "RePassword",
                onSaved: (String value) {
                  _passwordRepat = value;
                },
                labelText: "RePassWord",
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
