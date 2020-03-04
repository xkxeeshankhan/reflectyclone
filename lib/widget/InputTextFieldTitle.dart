import 'package:flutter/material.dart';

class InputTextFieldTitle extends StatefulWidget {
  final String title;
  final String bottomText;
  final TextEditingController controller;

  const InputTextFieldTitle({Key key, this.title, this.controller,this.bottomText})
      : super(key: key);

  @override
  _InputTextFieldTitleState createState() => _InputTextFieldTitleState();
}

class _InputTextFieldTitleState extends State<InputTextFieldTitle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller != null) {
      widget.controller.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          style: TextStyle(color: Colors.white, fontSize: 28.0),
          controller: widget.controller,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          showCursor: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.title ?? "",
              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w300,
                  fontSize: 28)),
        ),
        Row(
          children: <Widget>[
            Text(
              widget?.bottomText?.toUpperCase()??"",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.4)),
            ),
            Spacer(),
            Text(
              "${widget.controller?.text?.length ?? 0} / 40",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.4)),
            ),
          ],
        ),
      ],
    );
  }
}
