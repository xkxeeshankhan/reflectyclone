import 'package:flutter/material.dart';
import 'package:reflectly/res/colors.dart';

class NoInternetDialog extends StatelessWidget {
  final Function retry;
  const NoInternetDialog({Key key, this.retry}) : super(key: key);

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
                  "no internet connection".toUpperCase(),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(true);
                          try {
                            retry();
                          }catch(e){
                            print("No retry Function found");
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Retry",
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 16.0,
                              ),
                            ),
                          ),
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
