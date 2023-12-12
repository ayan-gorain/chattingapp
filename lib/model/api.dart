
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_user.dart';
import 'model/chat_user.dart';

class Apis {

  static FirebaseAuth auth = FirebaseAuth.instance;

  // For accessing Cloud Firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // For storing self information
  static late Chatuser me;

  // To return the current user
  static User get user => auth.currentUser!;

  // Function for checking if a user exists or not
  static Future<bool> userExists() async {
  var user = auth.currentUser;
  if (user != null) {
  var userDoc =
  await firestore.collection('userss').doc(user.uid).get();
  return userDoc.exists;
  }
  return false; // If user is not logged in
  }
  static Future<void> getselfInfo() async{
    await firestore.collection('userss').doc(user.uid).get().then((user) async {
      if(user.exists){
        me=Chatuser.fromJson(user.data()!);

      }else{
        await createUser().then((value)=> getselfInfo());

      }

    });
  }
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = {
      'id': user.uid,
      'name': user.displayName ?? '',
      'email': user.email ?? '',
      'about': "Hey, I'm using We Chat!",
      'image': user.photoURL ?? '',
      'createdAt': time,
      'isOnline': false,
      'lastActive': time,
      'pushToken': '', // You can add the push token here if available
    };
   // return await firestore.collection('userss').doc(user.uid).set(chatUser.toJson());

  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getallusers() {
    return FirebaseFirestore.instance.collection('userss').where('id',isNotEqualTo:user.uid).snapshots();
  }

  static Future<void> UpdateUserInfo() async{
    await firestore.collection('userss').doc(user.uid).update({
      'name':me.name,
      'about':me.about,
    });
  }
}


