import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final bool obscure;
  final FocusNode focusNode;
  final Function(String) validator;

  const InputTextField(
      {Key key, this.controller, this.hintText, this.obscure = false, this.validator, this.errorText, this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.0,
        letterSpacing: 0.2,
      ),
      controller: controller,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      showCursor: true,
      cursorColor: Colors.black,
      obscureText: obscure,
      focusNode: focusNode,
      validator:validator ,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.7), width: 2.0)),
          hintText: hintText ?? "",
//        errorText: errorText??"",

        focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.7), width: 2.0)),
          hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w300,
              letterSpacing: 0.2,
              fontSize: 22),
        errorStyle: TextStyle(
            color: Colors.red[800],
            fontWeight: FontWeight.w300,
            letterSpacing: 0.2,
            fontSize: 16)
      ),
    );
  }
}
