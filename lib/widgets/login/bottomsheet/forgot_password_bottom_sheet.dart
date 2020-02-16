import 'package:flutter/material.dart';
import 'package:late_box_book/customwidget/lb_text_form.dart';

class ForgotPasswordForm extends StatefulWidget {
  Function(String email) _funcEmail;

  ForgotPasswordForm(this._funcEmail);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              LBTextFormField(
                inputType: TextInputType.emailAddress,
                hintText: "Enter Email",
                onSaved: (String value) {
                  widget._funcEmail(value);
                },
                labelText: "Eamil",
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  height: 50,
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
                        child: Text(
                          "Send",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _formSubmit() {
    _formKey.currentState.save();
  }
}

