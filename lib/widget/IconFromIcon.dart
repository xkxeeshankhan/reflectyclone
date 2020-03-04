

import 'package:flutter/material.dart';
import 'package:reflectly/res/colors.dart';

class IconFromIcon extends StatelessWidget {
  final IconData icon;
  final Function onClick;

  final Color color;

  IconFromIcon({Key key, this.icon, this.onClick, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Icon(icon,size: 30,color: color?? darkGreyColor,),
    );
  }
}
