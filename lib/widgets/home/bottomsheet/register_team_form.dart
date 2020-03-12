import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:late_box_book/customwidget/lb_text_form.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterTeamForm extends StatefulWidget {
  Function(String teamName, bool isCreate, String currencyType,
      DateTime dailyStartTime) _funcOnTeam;

  RegisterTeamForm(this._funcOnTeam);

  @override
  _RegisterTeamFormState createState() => _RegisterTeamFormState();
}

class _RegisterTeamFormState extends State<RegisterTeamForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  DateTime dailyStartTime;
  String _teamName, _currencyType;

  var txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
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
                  _teamName = value;
                },
                labelText: "Team Name",
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Text("Scrum Master", style: TextStyle(fontSize: 12)),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: isSwitched,
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Daily Start Time",
                            style: TextStyle(fontSize: 12)),
                        TextField(
                          readOnly: true,
                          autofocus: false,
                          controller: txt,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                              hintText: "Daily Time",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 12.0)),
                          onTap: () {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true, onConfirm: (time) {
                              setState(() {
                                dailyStartTime = time;
                                txt.text =
                                    '${time.hour}:${time.minute}:${time.second}';
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SearchableDropdown.single(
                      items: getCurrencyList(),
                      value: _currencyType,
                      hint: "Currency Type",
                      searchHint: "Select one",
                      underline: Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _currencyType = value;
                          debugPrint(value);
                        });
                      },
                      isExpanded: true,
                    ),
                  ],
                ),
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
                        _formSubmit(isSwitched);
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
    widget._funcOnTeam(
        _teamName, isCreate, _currencyType, dailyStartTime);
  }

  List<DropdownMenuItem> getCurrencyList() {
    return [
      DropdownMenuItem(child: Text("TL"), value: "TL"),
      DropdownMenuItem(child: Text(r"$"), value: r"$"),
      DropdownMenuItem(child: Text(r"£"), value: r"£"),
    ];
  }
}
