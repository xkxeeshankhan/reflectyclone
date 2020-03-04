import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:reflectly/database/story.dart';
import 'package:reflectly/model/color.dart';
import 'package:reflectly/model/user.dart';
import 'package:reflectly/res/global.dart';

import 'internet.dart';

class Authenticate {

  FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference userCollection = Firestore.instance
      .collection("user");

  Future createUser({String email, String password}) async {
    try {

      if(!(await Internet().checkConnection())){
        return "No Internet Connection";
      }

      AuthResult result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      signINUserID = result.user.uid;

      await result.user.updateProfile(UserUpdateInfo()..displayName=(await UserModel.getName()));
      await UserModel(email: email,name: await UserModel.getName(),uid: result.user.uid).saveUpdatePrefs();
      await _saveCreatedUserData();
      await StoryDB().uploadStoriesFromPrefs();
      return 200;
    }catch(e){
      print(e);
      if(e is PlatformException){
        print(e.message);
        return 401;

      }
      return 400;

    }
  }

  Future _saveCreatedUserData() async{
    userCollection.document(signINUserID).setData(await UserModel().toJson());
  }


  signInWithEmailAndPassword({String email,String password}) async{
    try{

      if(!(await Internet().checkConnection())){
        return "No Internet Connection";
      }

      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      signINUserID = result.user.uid;
      await UserModel(email: email,uid: result.user.uid,name: result.user.displayName).saveUpdatePrefs();
      await getUserData();
      return 200;

    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }


  getUserData() async{
    return await userCollection.document(signINUserID).get().then((DocumentSnapshot documentSnapshot){
      if(documentSnapshot.data!=null){
        return ColorModel.fromJson(documentSnapshot.data)..saveInPrefs();
      }
      return null;
    });
  }

}
