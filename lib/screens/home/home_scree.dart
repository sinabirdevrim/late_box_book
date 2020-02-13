import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/blocs/user/user_bloc.dart';
import 'package:late_box_book/blocs/userdb/bloc.dart';
import 'package:late_box_book/common/notification_handler.dart';
import 'package:late_box_book/widgets/home/bottomsheet/register_team_form.dart';
import 'package:late_box_book/widgets/home/user_team_manager.dart';

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
  var keyStorageProfile = PageStorageKey("profileKey");
  UserFirestoreBloc _userFirestoreBloc;

  int bottomIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userFirestoreBloc = BlocProvider.of<UserFirestoreBloc>(context);
    NotificationHandler().initializeFCMNotification(context);
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserTeamManager().showUserTeamBottomSheet(
          widget.isNewUser, context, _userFirestoreBloc);
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
        children: <Widget>[
          DebtList(keyStorageHome),
          UserProfile(keyStorageProfile)
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Theme.of(context).primaryColor,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Theme.of(context).accentColor,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: TextStyle(color: Colors.grey[500]),
        ),
      ),
      child: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("HomePage")),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: Text("My Profile")),
        ],
        currentIndex: bottomIndex,
        onTap: (index) {
          setState(() {
            navigationTapped(index);
          });
        },
      ),
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
