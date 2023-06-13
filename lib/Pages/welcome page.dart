import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => SizedBox(
        width: 360.w,
        height: 780.w,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged:(index){

              },
              controller: PageController(

              ),
            )
          ],
        ),

      ))

    );
  }
}
