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

    Widget buildLogo(){
      return Container(
        width: 11,
        margin: EdgeInsets.only(top: 84.h),
        child: Column(
          children: [
            Container(
              width: 76.w,
              height: 76.w,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Positioned(child: Container(
                    height: 76.w,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.all(Radius.circular(35))
                    ),

                  ),

                  ),
                  Positioned(child: Image.asset('assets/images/ee.png',
                  width: 76.w,
                  height: 76.w,))
                ],
              ),
            )
          ],
        ),

      );
    }
    return Scaffold(

    );
  }
}

