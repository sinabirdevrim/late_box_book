import 'package:flutter/material.dart';

class LBTextFormField extends StatelessWidget {
  final String hintText;
  final FormFieldSetter<String> onSaved;
  final String labelText;
  final bool obscureText;
  final String initialValue;
  final TextInputType inputType;

  const LBTextFormField(
      {Key key,
      this.hintText,
      this.onSaved,
      this.labelText,
      this.obscureText = false,
      this.initialValue = "",
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(labelText, style: TextStyle(fontSize: 12)),
        TextFormField(
          keyboardType: inputType,
          initialValue: initialValue,
          obscureText: obscureText,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          onSaved: onSaved,
        ),
      ],
    );
  }
}
