

import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final bool inWhiteColor;
  const ErrorMessage(this.message,{this.inWhiteColor=false});


  @override
  Widget build(BuildContext context) {
    return Text(
      message??"",
      style: TextStyle(
        fontSize: 16,
        color: inWhiteColor? Colors.white:Colors.red[800],
        fontWeight: FontWeight.w300,
        letterSpacing: 0.2,
      ),
    );
  }
}
