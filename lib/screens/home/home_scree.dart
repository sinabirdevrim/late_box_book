import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/blocs/user/user_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: buildBottomNavigationBar(),
      body: BlocBuilder(
        bloc: _userBloc,
        builder: (_, UserState state) {
          return Center(
              child: RaisedButton(
            child: Text("LogOut"),
            onPressed: () {
              _userBloc.add(UserLogOutEvent());
            },
          ));
        },
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
            icon: Icon(Icons.book), title: Text("HomePage")),
      ],
      currentIndex: bottomIndex,
      onTap: (index) {
        setState(() {
          bottomIndex = index;
        });
      },
    );
  }
}
