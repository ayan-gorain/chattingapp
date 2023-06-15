import 'package:chatapp/Pages/SignIn/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
GoogleSignIn _googleSignIn=GoogleSignIn(
  scopes: <String>[
    'openId'
  ]

);

class SignInController extends GetxController{
  final state = SignInState();
  SignInController();
 final db=FirebaseFirestore.instance;
 Future <void> handleSignIn()async {
   try{
     var user=await  _googleSignIn.signIn();
     if(user!=null){
       String displayname=user.displayName??user.email;
       String email=user.email;
       String id=user.id;
       String photoUrl=user.photoUrl??"";
       UserLoginResponseEntity();

     }
   }catch(e){}

 }
  }


  
