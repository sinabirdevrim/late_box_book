import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/screens/login/login_screen.dart';
import 'package:late_box_book/util/const.dart';

import 'blocs/lb_bloc_delegate.dart';
import 'common/locator.dart';
import 'screens/landing_screen.dart';

void main() {
  BlocSupervisor.delegate = LBBlocDelegate();
  setupLocator();
  runZoned(() {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Constants.lightPrimary,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc()..add(UserIsLoginEvent()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme: Constants.lightTheme,
          home: LandingScreen()),
    );
  }
}
