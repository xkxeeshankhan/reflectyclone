import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reflectly/database/user.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/res/stringimage.dart';
import 'package:reflectly/res/validation.dart';
import 'package:reflectly/widget/ErrorMessage.dart';
import 'package:reflectly/widget/InputTextField.dart';
import 'package:reflectly/widget/button.dart';

class SignUpBottomSheet extends StatefulWidget {
  @override
  _SignUpBottomSheetState createState() => _SignUpBottomSheetState();
}

class _SignUpBottomSheetState extends State<SignUpBottomSheet> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmController;

  FocusNode _confirmPasswordFocus;

  String serverErrorMessage;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    _confirmPasswordFocus = FocusNode();

    _confirmPasswordFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: <Widget>[body()],
    );
  }

  Widget body() {
    return Container(
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(0, -50, 0),
            child: _emoji(),
          ),
          Container(
            transform: Matrix4.translationValues(0, -30, 0),
            child: Text(
              "Let's get your account finished up:",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 18.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                InputTextField(
                  controller: _emailController,
                  hintText: "Email",
                  validator: (text) =>
                      !validEmail(text) ? "Invalid Email" : null,
                ),
                SizedBox(
                  height: 15,
                ),
                InputTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscure: true,
                  validator: (text) => !validPassword(text)
                      ? "Password must be 6 char long"
                      : null,
                ),
                SizedBox(
                  height: 15,
                ),
                InputTextField(
                  controller: _confirmController,
                  hintText: "Confirm Password",
                  focusNode: _confirmPasswordFocus,
                  obscure: true,
                  validator: (text) =>
                      !validConfirmPassword(text, _passwordController.text)
                          ? "Password Mismatch"
                          : null,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "To ensure a safe account, "
                  "we require your password to"
                  " be at least 8 characters, "
                  "including an upper case letter "
                  "and a number.",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.6)),
                ),
                serverErrorMessage == null
                    ? Container()
                    : ErrorMessage(serverErrorMessage),
                SizedBox(
                  height: serverErrorMessage == null ? 30 : 10,
                ),
                RoundedButton(
                  width: .8,
                  onPressed: _createAccount,
                  text: "Create account",
                  showGradient: true,
                  loading: loading,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                Text("By continuing, you agree to our",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.black.withOpacity(0.7))),
                Text.rich(TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: endingColor,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: " and ",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                      TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: endingColor,
                            fontSize: 13,
                          )),
                    ])),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _emoji() {
    Size size = MediaQuery.of(context).size;
    bool condition = true;
    return AnimatedContainer(
      height: condition ? 95 : 70,
      width: condition ? size.width : 70,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(left: condition ? 0 : 25),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: condition ? 75 : 60,
              width: condition ? 75 : 60,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(0, condition ? 20 : 10)),
              ]),
            ),
          ),
          Center(child: Image.asset(REFLECTLY_GIF)),
        ],
      ),
      duration: Duration(milliseconds: 500),
    );
  }

  ///Functions

  _createAccount() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      loading = true;
      serverErrorMessage = null;
    });
    var result = await Authenticate().createUser(
        email: _emailController.text, password: _passwordController.text);
    if (!mounted) return;
    setState(() {
      loading = false;
    });

    if (result is int) {
      if (result == 200) {
        Navigator.of(context).pop("success");
      }
    } else if (result is String) {
      setState(() {
        serverErrorMessage = result;
      });
    } else {
      setState(() {
        serverErrorMessage = "Please Try Again!";
      });
    }
  }
}
