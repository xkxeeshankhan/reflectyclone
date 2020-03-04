import 'package:flutter/material.dart';
import 'package:reflectly/database/user.dart';
import 'package:reflectly/pages/bottomnav/home.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/res/validation.dart';
import 'package:reflectly/widget/ErrorMessage.dart';
import 'package:reflectly/widget/button.dart';

import '../../dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool loading = false;
  String serverErrorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [startingColor, endingColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Text(
                "Account\nLogin",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.08),
                    fontSize: size.height*0.08,
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.w800),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                          controller: _emailController,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          showCursor: true,
                          cursorColor: Colors.white,
                          validator: (text) =>
                              validEmail(text) ? null : "Invalid Account Email",
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22),
                              errorStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16)),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Account email".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                          controller: _passwordController,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          showCursor: true,
                          obscureText: true,
                          cursorColor: Colors.white,
                          validator: (text) => validPassword(text)
                              ? null
                              : "Password must be 6 Char long",
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w300,
                                fontSize: 22),
                            errorStyle: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Account Password".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                            Spacer(),
                            Text(
                              "Forget?",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        MediaQuery.of(context).viewInsets.bottom != 0?Container():serverErrorMessage == null
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: ErrorMessage(
                                  serverErrorMessage,
                                  inWhiteColor: true,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom != 0
                  ? Container()
                  : RoundedButton(
                      width: .8,
                      onPressed: _signInAuth,
//                          () {
//                        Navigator.of(context)
//                            .popUntil((route) => route.isFirst);
//                        Route route = MaterialPageRoute(
//                          builder: (context) => DashboardView(),
//                        );
//                        Navigator.of(context).pushReplacement(route);
//                      },
                      text: "Sign in",
                      color: endingColor,
                      loading: loading,
                    ),
              MediaQuery.of(context).viewInsets.bottom != 0
                  ? Container()
                  : SizedBox(
                      height: 40,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _signInAuth() async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      serverErrorMessage = null;
      loading = true;
    });

    try {
      var result = await Authenticate().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        loading = false;
      });

      print(result);

      if (result is int) {
        if (result == 200) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Route route = MaterialPageRoute(
            builder: (context) => DashboardView(),
          );
          Navigator.of(context).pushReplacement(route);
        }
      } else {
        setState(() {
          serverErrorMessage = result;
        });
      }
    } catch (e) {
      print(">>>>>>>ERROR $e<<<<<<<<<<");
    }
  }
}
