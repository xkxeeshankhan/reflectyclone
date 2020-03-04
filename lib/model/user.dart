import 'package:flutter/material.dart';
import 'package:reflectly/model/color.dart';
import 'package:reflectly/pages/onlaunch/landing.dart';
import 'package:reflectly/res/global.dart';
import 'package:reflectly/res/globalClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String name;
  String uid;
  String email;

  UserModel({this.name, this.uid, this.email});

  saveUpdatePrefs() async {
    print("---Saving USer Data---");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (name != null) prefs.setString("user_name", name);
    if (uid != null) prefs.setString("user_uid", uid);
    if (email != null) prefs.setString("user_email", email);
  }

  static Future<String> getName() async =>
      (await SharedPreferences.getInstance()).getString("user_name");

  static Future<String> getUID() async =>
      (await SharedPreferences.getInstance()).getString("user_uid");

  static Future<String> getEmail() async =>
      (await SharedPreferences.getInstance()).getString("user_email");

  Future<Map<String, dynamic>> toJson() async {
    ColorModel colorModel = await ColorModel().fromPrefs();
    return {
      "name": (await getName()),
      "starting_color": colorModel.startColor,
      "ending_color": colorModel.endColor
    };
  }

  static clearPrefsLogout() async {
    print("********Clear Prefs**********");
    (await SharedPreferences.getInstance()).clear();
    signINUserID = "the_authenticated_user_id";
    Global.navigatorKey.currentState.popUntil((route) => route.isFirst);
    Global.navigatorKey.currentState.pushReplacement(MaterialPageRoute(
      builder: (context) => LandingPage(),
    ));
  }
}
