import 'package:flutter/material.dart';
import 'package:late_box_book/customwidget/lb_text_form.dart';

class RegisterFormCard extends StatefulWidget {
  Function(String _email) funcEmail;
  Function(String _password) funcPassword;
  Function(String _rePassword) funcRePassword;
  Function(String _nameAndSurname) funcNameAndSurname;
  GlobalKey<FormState> _formKey;

  RegisterFormCard(this.funcEmail, this.funcPassword, this.funcRePassword,
      this._formKey, this.funcNameAndSurname);

  @override
  _RegisterFormCardState createState() => _RegisterFormCardState();
}

class _RegisterFormCardState extends State<RegisterFormCard> {
  bool switchState = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: 400,
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
              Text("Register",
                  style: TextStyle(fontSize: 25, letterSpacing: .6)),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                hintText: "Name Surname",
                onSaved: (String value) {
                  widget.funcNameAndSurname(value);
                },
                labelText: "Name Surname",
              ),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                hintText: "Email",
                onSaved: (String value) {
                  widget.funcEmail(value);
                },
                labelText: "Email",
              ),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                obscureText: true,
                hintText: "Password",
                onSaved: (String value) {
                  widget.funcPassword(value);
                },
                labelText: "Password",
              ),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                obscureText: true,
                hintText: "RePassword",
                onSaved: (String value) {
                  widget.funcRePassword(value);
                },
                labelText: "RePassword",
              ),
              SizedBox(
                height: 5,
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
