import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reflectly/model/questionmodel.dart';

class QuestionDB {
  final CollectionReference _questionCollection =
      Firestore.instance.collection("question");

dispose(){
  _questionCollection.snapshots().map(_questionFromSnapshotToJson).listen((item){}).cancel();
}

  Future<QuestionModel>  get randomQuestion {
    return _questionCollection.snapshots().map(_questionFromSnapshotToJson).first;
  }

  QuestionModel _questionFromSnapshotToJson(QuerySnapshot snapshot) {
    print(snapshot.documents);

    List<QuestionModel> questions = snapshot.documents.map((snap) {
      var json = snap.data;
      String id = snap.documentID;

      return QuestionModel.fromJson(json: json, id: id);
    }).toList();

    Random rnd = Random();
    int index = _next(0,questions.length-1,rnd);
    return questions[index];
  }

  int _next(int min, int max, Random rnd) => min + rnd.nextInt(max - min);
}
