import 'package:flutter/material.dart';
import 'package:late_box_book/blocs/userdb/bloc.dart';
import 'package:late_box_book/common/notification_handler.dart';

import 'bottomsheet/register_team_form.dart';

class UserTeamManager {
  void showUserTeamBottomSheet(bool isNewUser, BuildContext context,
      UserFirestoreBloc _userFirestoreBloc) {
    if (isNewUser) {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (_) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: RegisterTeamForm((teamName, isMaster) {
                  if (isMaster) {
                    _userFirestoreBloc
                        .add(UserFirestoreCreateFireStoreEvent(teamName));
                  } else {
                    _userFirestoreBloc
                        .add(UserFirestoreJoinFireStoreEvent(teamName));
                  }
                  _userFirestoreBloc.add(UserFirestoreGetUsereEvent(teamName));
                  NotificationHandler().getUserToken((token) {
                    _userFirestoreBloc
                        .add(UserFirestoreSaveUserTokenEvent(token));
                    Navigator.pop(context);
                  });
                }),
              ),
            );
          });
    } else {
      _userFirestoreBloc.add(UserFirestoreGetUsereEvent());
      NotificationHandler().getUserToken((token) {
        _userFirestoreBloc.add(UserFirestoreSaveUserTokenEvent(token));
      });
    }
  }
}
