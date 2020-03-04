import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/widget/button.dart';

class SubscriptionView extends StatefulWidget {
  @override
  _SubscriptionViewState createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: lightBlueColor,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 20),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.keyboard_backspace,
                            size: 35,
                            color: lightGreyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.all(3),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 20.0,
                              spreadRadius: -40.0,
                              offset: Offset(0, 44))
                        ],
                        gradient: LinearGradient(
                            colors: [endingColor, startingColor],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                    height: 180,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Best value - save 58%".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(25.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "12 months",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                            Text("€3.33",
                                                style: TextStyle(
                                                    color: darkGreyColor2,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "39,99 €",
                                              style: TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Spacer(),
                                            Text("per month",
                                                style: TextStyle(
                                                    color: darkGreyColor2,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: lightBlueColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      )),
                                  child: Center(
                                    child: Text(
                                      "includes 7-day free trial".toUpperCase(),
                                      style: TextStyle(
                                          color: darkGreyColor2,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.all(25),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 20.0,
                            spreadRadius: -40.0,
                            offset: Offset(0, 44))
                      ],
                    ),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "1 month",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Spacer(),
                            Text("€7.33",
                                style: TextStyle(
                                    color: darkGreyColor2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "7,99 €",
                              style: TextStyle(
                                  color: darkGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Spacer(),
                            Text("per month",
                                style: TextStyle(
                                    color: darkGreyColor2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  )

//                  Container(
//                    height: 180,
//                    child: Stack(
//                      children: <Widget>[
//                        Positioned(
//                          bottom: 0,
//                          right: 0,
//                          left: 0,
//                          child: Center(
//                            child: Container(
//                              width: size.width * .6,
//                              height: 20,
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(20),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.black38,
//                                      blurRadius: 20.0,
//                                      spreadRadius: 0.0,
//                                      offset: Offset(0, 4))
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                        Container(
//                          margin: EdgeInsets.symmetric(horizontal: 30),
//                          padding: EdgeInsets.all(3),
//                          width: double.maxFinite,
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(20),
//                              gradient: LinearGradient(
//                                  colors: [endingColor, startingColor],
//                                  begin: Alignment.centerLeft,
//                                  end: Alignment.centerRight)),
//                          height: 180,
//                          child: Column(
//                            children: <Widget>[
//                              Padding(
//                                padding:
//                                    const EdgeInsets.symmetric(vertical: 15),
//                                child: Text(
//                                  "Best value - save 58%".toUpperCase(),
//                                  style: TextStyle(
//                                      color: Colors.white,
//                                      fontSize: 15,
//                                      fontWeight: FontWeight.w500),
//                                ),
//                              ),
//                              Expanded(
//                                child: Container(
//                                  width: double.maxFinite,
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.only(
//                                        bottomLeft: Radius.circular(20),
//                                        bottomRight: Radius.circular(20)),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  )
                ],
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(0, -30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: RoundedButton(
                    onPressed: () {},
                    text: "start free trial",
                    width: .8,
                    showGradient: true,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Subscriptions bulled as one payment. Recurring billing.\nCancel anytime for any reason.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "By continuing, you agree to our",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text.rich(
                  TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: " and ",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
