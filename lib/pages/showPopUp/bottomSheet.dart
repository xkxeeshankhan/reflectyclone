
import 'package:flutter/material.dart';
import 'package:reflectly/pages/auth/signup.dart';
import 'package:reflectly/res/colors.dart';

showSignUpSheet(BuildContext context,{Function onSuccess}){
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SignUpBottomSheet(),
      backgroundColor: lightBlueColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ))).then((response) {
    if (response == "success") {
      onSuccess();
//      storyDB.dispatch();
    }
  });
}
