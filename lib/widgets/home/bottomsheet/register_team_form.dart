import 'package:flutter/material.dart';
import 'package:late_box_book/customwidget/lb_text_form.dart';

class RegisterTeamForm extends StatefulWidget {
  Function(String teamName, bool isCreate, String currencyType) _funcOnTeam;
  String _teamName, _currencyType;

  RegisterTeamForm(this._funcOnTeam);

  @override
  _RegisterTeamFormState createState() => _RegisterTeamFormState();
}

class _RegisterTeamFormState extends State<RegisterTeamForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text("Team Info",
                  style: TextStyle(fontSize: 25, letterSpacing: .6)),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                hintText: "Enter Team Name",
                onSaved: (String value) {
                  widget._teamName = value;
                },
                labelText: "Team Name",
              ),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                hintText: "Enter Currency Type (Only Master)",
                onSaved: (String value) {
                  widget._currencyType = value;
                },
                labelText: "Currency Type Short(Exp: TL)",
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
                        _formSubmit(false);
                      },
                      child: Center(
                        child: Text(
                          "Join",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  horizontalLine(),
                  Text("Or",
                      style: TextStyle(
                          fontSize: 16.0, fontFamily: "Poppins-Medium")),
                  horizontalLine()
                ],
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
                        _formSubmit(true);
                      },
                      child: Center(
                        child: Text(
                          "Create",
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

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 90,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  void _formSubmit(bool isCreate) {
    _formKey.currentState.save();
    widget._funcOnTeam(widget._teamName, isCreate, widget._currencyType);
  }
}
