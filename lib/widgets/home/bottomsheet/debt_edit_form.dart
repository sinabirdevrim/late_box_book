import 'package:flutter/material.dart';
import 'package:late_box_book/customwidget/lb_text_form.dart';

class DeptEditForm extends StatefulWidget {
  Function(String amount, String payment) _funcAmount;
  String _userName, _totalDept;
  String _currentAmount, _currentPayment;

  DeptEditForm(this._funcAmount, this._userName, this._currentAmount,
      this._currentPayment);

  @override
  _DeptEditFormState createState() => _DeptEditFormState();
}

class _DeptEditFormState extends State<DeptEditForm> {
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
              Text(widget._userName,
                  style: TextStyle(fontSize: 25, letterSpacing: .6)),
              SizedBox(
                height: 15,
              ),
              LBTextFormField(
                initialValue: widget._currentAmount,
                hintText: "Enter Total Dept Amount",
                onSaved: (String value) {
                  widget._totalDept = value;
                },
                labelText: "Total Dpet Amount",
              ),
              SizedBox(
                height: 20,
              ),
              LBTextFormField(
                initialValue: widget._currentPayment,
                hintText: "Enter Total Payment Amount",
                onSaved: (String value) {
                  widget._funcAmount(widget._totalDept, value);
                },
                labelText: "Total Payment Amount",
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
                          "Edit",
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
