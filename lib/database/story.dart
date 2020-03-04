import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reflectly/model/storymodel.dart';
import 'package:reflectly/res/global.dart';

class StoryDB {
  String uuid;

  StreamController<List<StoryModel>> _streamController = StreamController<List<StoryModel>>();

  final CollectionReference storyCollection = Firestore.instance
      .collection("user");

  List<StoryModel> _storyListFomrSnapshotToJson(QuerySnapshot snapshot) {
    return snapshot.documents.map((snap) {
      var json = snap.data;
      String id = snap.documentID;

      return StoryModel.fromJson(json: json, id: id);
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Stream<List<StoryModel>> get stories => _streamController.stream;

  dispatch() async{
    if(signINUserID!="the_authenticated_user_id") {
      print("-----User Is Authenticated getStoreies--------");
      Stream stream = storyCollection.document(signINUserID)
          .collection("story").snapshots().map(_storyListFomrSnapshotToJson);
      stream.listen((data)=>_streamController.add(data));
    }else{
      print("-----Default User getStoreies--------");
      _streamController.add(await StoryModel.getStoriesFromPrefs());
    }
  }

  uploadStoriesFromPrefs() async {
    ///Sending stored stories to server and clear prefs for store stories
    List<StoryModel> stories = await StoryModel.getStoriesFromPrefs();
    if (stories.length > 0) {
      stories.forEach((story) {
        storyCollection.document(signINUserID)
            .collection("story").document().setData(story.toJson());
      });

      StoryModel.clearStoriesPrefs();
    } else {
      print("No Story found");
    }
  }
}
