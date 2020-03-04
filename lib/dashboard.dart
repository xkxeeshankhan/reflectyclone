import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reflectly/pages/showPopUp/bottomSheet.dart';
import 'package:reflectly/pages/bottomnav/home.dart';
import 'package:reflectly/pages/subscription.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/res/global.dart';
import 'package:reflectly/res/stringimage.dart';
import 'package:reflectly/widget/IconFromIcon.dart';
import 'package:reflectly/widget/IconFromImage.dart';

import 'model/user.dart';
import 'widget/BottomNavigationBarItem.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int pageViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: lightBlueColor,
      body: _pageSelection(),
      bottomNavigationBar: BottomNavigationDotBar(
        activeColor: darkGreyColor,
        items: [
          BottomNavigationDotBarItem(
              icon: IconFromImage(
                imageUrl: WRITE_IMAGE,
                color: pageViewIndex == 0 ? darkGreyColor : lightGreyColor,
              ),
              onTap: () {
                setState(() {
                  pageViewIndex = 0;
                });
              }),
          BottomNavigationDotBarItem(
              icon: IconFromIcon(
                icon: Icons.gesture,
                color: pageViewIndex == 1 ? darkGreyColor : lightGreyColor,
              ),
              onTap: () {
                setState(() {
                  pageViewIndex = 1;
                });
              }),
          BottomNavigationDotBarItem(
              icon: IconFromIcon(
                icon: Icons.person_outline,
                color: pageViewIndex == 2 ? darkGreyColor : lightGreyColor,
              ),
              onTap: () {
                setState(() {
                  setState(() {
                    pageViewIndex = 2;
                  });
                });
              }),
        ],
        color: Colors.white,
      ),
    );
  }

  Widget _pageSelection() {
    switch (pageViewIndex) {
      case 0:
        return HomeView();
        break;
      case 1:
        return _demo();
        break;
      case 2:
        return Container();
        break;
    }
  }

  _demo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _signup_logout,
            child: Text(
              signINUserID == "the_authenticated_user_id"
                  ? "Sign up"
                  : "Sign out",
              style: TextStyle(
                  fontSize: 22.0,
                  color: endingColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          signINUserID == "the_authenticated_user_id"
              ? InkWell(
                  onTap: UserModel.clearPrefsLogout,
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                        fontSize: 22.0,
                        color: endingColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  _signup_logout() async {
//    (await SharedPreferences.getInstance()).clear();
//    return;
    if (signINUserID == "the_authenticated_user_id")
      showSignUpSheet(context, onSuccess: () {
        setState(() {});
      });
    else
      UserModel.clearPrefsLogout();
  }
}
