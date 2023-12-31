import 'package:chatapp/pages/welcomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/chat_user.dart';
import '../model/api.dart';




class Signnn extends StatefulWidget {
   Signnn({super.key});

  @override
  State<Signnn> createState() => _SignnnState();
}

class _SignnnState extends State<Signnn> {
  void initState() {
    super.initState();
    setSystemUIOverlayStyle(); // Call the method to set the system UI overlay style
  }

  void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // Navigation bar color
        statusBarColor: Colors.white, // Status bar color
      ),
    );
  }

  @override
  void dispose() {
    // Ensure to dispose the changes when the widget is disposed
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage("assets/images/ee.png"),height: 300.h,),
              Center(
                child: Text("AisAy Connectify",style: TextStyle(
                  fontFamily: 'DancingScript',fontWeight:FontWeight.w700,fontSize:50.sp,color: Colors.purpleAccent
                ),),
              ),
              SizedBox(
                height: 100.h,
              ),

              SizedBox(height: 50.h,),
              SizedBox(
                height: 70.h,
                width: 200.w,
                child: OutlinedButton(
                  onPressed: () {
                    logIn(context);
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.purpleAccent, width: 4.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google Icon
                      FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.black,
                        size: 25.sp,
                      ),
                      SizedBox(width: 20.w), // Add some space between icon and text
                      // Sign In Text
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 25.sp, // Use sp for font sizes when using flutter_screenutil
                        ),
                      ),
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  Future<void> logIn(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        final x = SnackBar(
          content: const Text("Please select an account!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(x);
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      var auth = FirebaseAuth.instance;
      final UserCredential userCredential =
      await auth.signInWithCredential(authCredential);

      final User? user = userCredential.user;

      if (user != null) {
        await user.reload();

        final User? refreshedUser = auth.currentUser;

        if (refreshedUser != null) {
          if (refreshedUser.email != null && refreshedUser.email!.isNotEmpty) {
            bool doesUserExist = await userExists(refreshedUser.uid);

            if (doesUserExist) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => welco()),
              );
            } else {
              await createUser(refreshedUser);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => welco( )),
              );
            }
          }
        }
      }

      User? userr = userCredential.user;
      if (userr != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection("users").doc(userr.uid).set(
            {
              'username': userr.displayName,
              'uid': userr.uid,
              // Other data you might want to add for a new user
            },
          );
        }
      }
    } catch (e) {
      print("Error during login: $e");
      // Handle the error or display an error message if necessary
    }
  }

  Future<bool> userExists(String uid) async {
    DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('userss').doc(uid).get();
    return userSnapshot.exists;
  }

  Future<void> createUser(User user) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = Chatuser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      about: "Hey, I'm using We Chat!",
      image: user.photoURL ?? '',
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '', // Add the push token here
    );

    await FirebaseFirestore.instance
        .collection('userss')
        .doc(user.uid)
        .set(chatUser.toJson());
  }
}


