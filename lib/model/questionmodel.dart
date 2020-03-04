

class QuestionModel{
  String id;
  String questionText;

  QuestionModel({this.id, this.questionText});

  QuestionModel.fromJson({Map<String,dynamic> json,String id}){
    print(id);
    this.id = id;
    this.questionText = json['question_text'];
  }

}