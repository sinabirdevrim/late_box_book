import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/blocs/user/user_bloc.dart';
import 'package:late_box_book/blocs/userdb/bloc.dart';
import 'package:late_box_book/common/notification_handler.dart';
import 'package:late_box_book/widgets/home/bottomsheet/register_team_form.dart';

import 'debtlist/debt_list.dart';
import 'user_profile/user_profile.dart';

class HomeScreen extends StatefulWidget {
  bool isNewUser;

  HomeScreen(this.isNewUser);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var keyStorageHome = PageStorageKey("homeKey");

  int bottomIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationHandler().initializeFCMNotification(context);
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isNewUser) {
        showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (_) {
              return RegisterTeamForm((teamName, isMaster) {
                if (isMaster) {
                  BlocProvider.of<UserFirestoreBloc>(context)
                      .add(UserFirestoreCreateFireStoreEvent(teamName));
                  Navigator.pop(context);
                } else {
                  BlocProvider.of<UserFirestoreBloc>(context)
                      .add(UserFirestoreJoinFireStoreEvent(teamName));
                  Navigator.pop(context);
                }
                BlocProvider.of<UserFirestoreBloc>(context).add(UserFirestoreGetUsereEvent());
                NotificationHandler().getUserToken((token){
                  debugPrint(token);
                  BlocProvider.of<UserFirestoreBloc>(context).add(UserFirestoreSaveUserTokenEvent(token));
                });
              });
            });
      }else{
        BlocProvider.of<UserFirestoreBloc>(context).add(UserFirestoreGetUsereEvent());
        NotificationHandler().getUserToken((token){
          debugPrint(token);
          BlocProvider.of<UserFirestoreBloc>(context).add(UserFirestoreSaveUserTokenEvent(token));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: buildBottomNavigationBar(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[DebtList(keyStorageHome), UserProfile()],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text("HomePage")),
        BottomNavigationBarItem(
            icon: Icon(Icons.book), title: Text("My Acount")),
      ],
      currentIndex: bottomIndex,
      onTap: (index) {
        setState(() {
          navigationTapped(index);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this.bottomIndex = page;
    });
  }
}
