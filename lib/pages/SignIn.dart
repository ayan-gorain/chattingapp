import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signnn extends StatelessWidget {
  const Signnn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50,top: 90),
              child: Image(image: AssetImage("assets/images/ee.png"),height: 300,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Text("Temple Run",style: TextStyle(
                fontFamily: 'DancingScript',fontWeight:FontWeight.w700,fontSize:70,
              ),),
            ),
            SizedBox(
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text("Sign up with your social media",style: TextStyle(
                fontWeight:FontWeight.w700,fontSize:20,
              ),),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child:   SizedBox(
                height: 70,
                width: 200,
                child: OutlinedButton(
                  child: Text('Sign In',style: TextStyle(
                      fontSize: 25
                  ),),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.red, width: 3),

                  ),
                  onPressed: () {
                    logIn(context);

                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  Future<void> logIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      var auth = FirebaseAuth.instance;
      await auth.signInWithCredential(authCredential);
      // Navigator.pushReplacement(
      // context, MaterialPageRoute(builder: (context) => const RealHomeScreen()));
    }
    else{
      final x = SnackBar(content: const Text("Please select an account!"),);
      ScaffoldMessenger.of(context).showSnackBar(x);
    }
  }
}


