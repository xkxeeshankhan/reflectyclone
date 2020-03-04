

import 'package:cloud_firestore/cloud_firestore.dart';

class ImageDB{

  String uuid;


  ImageDB(this.uuid);

  final CollectionReference _imageCollection = Firestore.instance
      .collection("image");


  Future<String> get imageURL{
    print(uuid);
    return _imageCollection.document(uuid).get().then((DocumentSnapshot doc){
      if(doc.data!=null){
        return doc.data['image'];
      }
      return null;
    });
  }

}