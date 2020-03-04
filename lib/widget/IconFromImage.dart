import 'package:flutter/material.dart';
import 'package:reflectly/res/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class IconFromImage extends StatelessWidget {
  final String imageUrl;
  final Function onClick;

  final Color color;

  IconFromImage({Key key, this.imageUrl, this.onClick, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClick,
        child: Image.asset(
          imageUrl,
          height: 25,
          width: 25,
          color: color?? darkGreyColor,
        ));
  }
}
