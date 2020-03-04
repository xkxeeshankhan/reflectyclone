import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reflectly/dashboard.dart';
import 'package:reflectly/pages/onlaunch/splashScreen.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/res/global.dart';
import 'package:reflectly/res/globalClass.dart';

import 'model/color.dart';
import 'model/user.dart';
import 'pages/onlaunch/landing.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Reflectly Demo',
        navigatorKey: Global.navigatorKey,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: ScreenSelection());
  }
}

class ScreenSelection extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ScreenSelectionState createState() => _ScreenSelectionState();
}

class _ScreenSelectionState extends State<ScreenSelection> {
  bool showSplash = false;
  bool userExist = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfUserExist();
//    Future.delayed(Duration.zero,_checkIfUserExist);
  }

  _checkIfUserExist() async {
    String userId = await UserModel.getUID();
    if (userId != null) {
      signINUserID = userId;
      ColorModel model = await ColorModel().fromPrefs();
      startingColor = Color(model.startColor);
      endingColor = Color(model.endColor);

      setState(() {
        userExist = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userExist
        ? DashboardView()
        : showSplash ? SplashScreen() : LandingPage();
  }
}
