import 'package:flutter/material.dart';
import 'package:reflectly/res/colors.dart';

import 'Loading.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final double width;
  final String text;
  final bool showGradient;
  final bool loading;

//

  RoundedButton(
      {this.color,
      this.onPressed,
      this.width,
      this.text = "",
      this.showGradient = false,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          gradient: showGradient
              ? LinearGradient(
                  colors: [endingColor, startingColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          boxShadow: [
            BoxShadow(
                color: endingColor.withOpacity(0.8),
                blurRadius: 22,
                spreadRadius: -20,
                offset: Offset(0, 22)),
            BoxShadow(
                color: endingColor.withOpacity(0.8),
                blurRadius: 22,
                spreadRadius: -20,
                offset: Offset(0, 22))
          ]),
      child: loading
          ? SizedBox(
              height: 60,
              child: Loading(
                showingOnGradient: showGradient,
              ))
          : InkWell(
              onTap: onPressed,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color:
                  showGradient ? Colors.white.withOpacity(0.0) : Colors.white,

                ),
                width: size.width * .8,
                height: 60,
                child: Center(
                  child: Text(
                    text.toUpperCase(),
                    style: TextStyle(
                        color: showGradient ? Colors.white : color,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                        fontSize: 18.0),
                  ),
                ),
              )),
    );
  }
}
