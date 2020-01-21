import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LBTextFormField extends StatelessWidget {
  final String hintText;
  final FormFieldSetter<String> onSaved;
  final String labelText;

  const LBTextFormField({Key key, this.hintText, this.onSaved, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(labelText,
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26))),
        TextFormField(
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
