import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../welcome/crontroller.dart';
import 'crontroller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);


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
                    print('Pressed');
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


}

