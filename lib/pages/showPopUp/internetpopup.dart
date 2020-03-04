import 'package:flutter/material.dart';
import 'package:reflectly/dialog/noInternet.dart';

showInternetDialog(BuildContext context,{Function retry}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => NoInternetDialog(retry: retry,));
}
