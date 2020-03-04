import 'package:flutter/material.dart';
import 'package:reflectly/res/colors.dart';

class CancelDialog extends StatelessWidget {
  final bool popTwoTimes;

  const CancelDialog({Key key, this.popTwoTimes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Text(
                  "are you sure?".toUpperCase(),
                  style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "This story will not be saved and you cannot get it back!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkGreyColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: lightGreyColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          if (popTwoTimes) Navigator.of(context).pop(true);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.red[200],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
