import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StoryModel {
  String id;
  DateTime date;
  double overAllDay;
  String reason;
  int feelWholeDay;
  String questionId;
  String answer;
  String title;
  String image;

  StoryModel(
      {this.id,
      this.date,
      this.overAllDay,
      this.reason,
      this.feelWholeDay,
      this.questionId,
      this.answer,
      this.image,
      this.title});

  StoryModel.fromJson({Map<String, dynamic> json, String id}) {
    this.id = id;
    this.date = DateTime.parse(json['date']);
    this.overAllDay = json['overall_day'];
    this.reason = json['reason'];
    this.feelWholeDay = json['feel_whole_day'];
    this.questionId = json['question_id'];
    this.answer = json['answer'];
    this.title = json['title'];
    this.image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date.toString().substring(0, 10),
      "overall_day": overAllDay,
      "reason": reason,
      "feel_whole_day": feelWholeDay,
      "question_id": questionId,
      "answer": answer,
      "title": title,
      "image": image
    };
  }

  saveStoryInPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("stories", (prefs.getStringList("stories")??[])..add(jsonEncode(toJson())));
  }

  static Future<List<StoryModel>> getStoriesFromPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList("stories")??[]).map((stringStory)=>StoryModel.fromJson(json: jsonDecode(stringStory))).toList();
  }

  static clearStoriesPrefs () async => (await SharedPreferences.getInstance()).remove("stories");

}
