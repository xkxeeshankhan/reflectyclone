
import 'dart:ui';

import 'package:reflectly/res/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorSelectionModel{
  Color startingColor;
  Color endingColor;

  ColorSelectionModel(this.startingColor, this.endingColor);

}

List<ColorSelectionModel> colorsList = [
  ColorSelectionModel(Color(0xff8084E1),Color(0xff7970C2)),
  ColorSelectionModel(Color(0xffFFC7A5),Color(0xffFF9C9C)),
  ColorSelectionModel(Color(0xffFD7183),Color(0xffF566A2)),
  ColorSelectionModel(Color(0xff5ECFA2),Color(0xff3C9EA8)),
  ColorSelectionModel(Color(0xff719AEF),Color(0xff3C9CA9)),
  ColorSelectionModel(Color(0xff00D8D3),Color(0xff00B4D5)),
];

class ColorModel{
  int startColor;
  int endColor;

  ColorModel();

  ColorModel.withParams(this.startColor, this.endColor);

  ColorModel.fromJson(Map<String,dynamic> json){
    startColor = json['starting_color'];
    endColor = json['ending_color'];
  }


  saveInPrefs() async{
    print("--startingColor $startColor--");
    print("--endingColor $endColor--");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    startingColor = Color(startColor);
    endingColor = Color(endColor);
    prefs.setInt("starting_color", startColor);
    prefs.setInt("ending_color", endColor);
  }

  Future<ColorModel> fromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    startColor = prefs.getInt("starting_color");
    endColor = prefs.getInt("ending_color");

    return this;
  }

}