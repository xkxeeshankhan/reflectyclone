import 'package:flutter/material.dart';
import 'package:reflectly/pages/auth/login.dart';
import 'package:reflectly/pages/auth/welcome.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/res/stringimage.dart';
import 'package:reflectly/widget/button.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [startingColor, endingColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: 95,
              width: size.width,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 100, left: 0),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 75,
                      width: 75,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 20)),
                      ]),
                    ),
                  ),
                  Center(child: Image.asset(REFLECTLY_GIF)),
                ],
              ),
              duration: Duration(milliseconds: 500),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hi there,\nI'm Reflectly",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Your new personal\njournaling companion",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.6),
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w300),
            ),
            Spacer(),
            RoundedButton(
              width: .8,
              onPressed: () {
                Route route = MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                );
                Navigator.of(context).push(route);
              },
              text: "Hi, Reflectly!",
              color: endingColor,
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {
                Route route = MaterialPageRoute(
                  builder: (context) => LoginPage(),
                );
                Navigator.of(context).push(route);
              },
              child: Text(
                "I already have an account".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
