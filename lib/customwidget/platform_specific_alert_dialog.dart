import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:late_box_book/customwidget/platform_specific_widget.dart';

class PlatformSpecificAlertDialog extends PlatformSpecificWidget {
  final String header;
  final String title;
  final String doneText;
  final String donel2Text;
  final Function(bool isDone) onDialogClick;

  PlatformSpecificAlertDialog(
      {@required this.header,
      @required this.title,
      @required this.doneText,
      this.donel2Text,
      this.onDialogClick});

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: false);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(header),
      content: Text(title),
      actions: _dialogButtonsSetting(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(header),
      content: Text(title),
      actions: _dialogButtonsSetting(context),
    );
  }

  List<Widget> _dialogButtonsSetting(BuildContext context) {
    final buttons = <Widget>[];

    if (Platform.isIOS) {
      if (donel2Text != null) {
        buttons.add(
          CupertinoDialogAction(
            child: Text(donel2Text),
            onPressed: () {
              Navigator.of(context).pop(false);
              if (onDialogClick != null) {
                onDialogClick(false);
              }
            },
          ),
        );
      }

      buttons.add(
        CupertinoDialogAction(
          child: Text(doneText),
          onPressed: () {
            Navigator.of(context).pop(true);
            if (onDialogClick != null) {
              onDialogClick(true);
            }
          },
        ),
      );
      buttons.add(
        CupertinoDialogAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (donel2Text != null) {
        buttons.add(
          FlatButton(
            child: Text(donel2Text),
            onPressed: () {
              Navigator.of(context).pop(false);
              if (onDialogClick != null) {
                onDialogClick(false);
              }
            },
          ),
        );
      }

      buttons.add(
        FlatButton(
          child: Text(doneText),
          onPressed: () {
            Navigator.of(context).pop(true);
            if (onDialogClick != null) {
              onDialogClick(true);
            }
          },
        ),
      );
      buttons.add(
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    }

    return buttons;
  }
}
