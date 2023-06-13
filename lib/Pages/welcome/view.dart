import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'crontroller.dart';

class WelcomePage extends GetView<welcomeController> {
  const WelcomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(()=>SizedBox(
          width: 360.w,
          height: 780.w,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                scrollDirection: Axis.horizontal,
                reverse: false,
                onPageChanged: (index) {
                  controller.changePage(index);

                },
                controller: PageController(
                    initialPage: 0, keepPage: false, viewportFraction: 1

                ),
                pageSnapping: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/wel.png'

                            )
                        )
                    ),
                  ), Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/wel2.png'

                            )
                        )
                    ),
                  ), Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/wel3.png'

                            )
                        )
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 90,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 170),
                            child: ElevatedButton(
                              child: Text('Login'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.lightGreenAccent),
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.black),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10)
                                      ))
                              ),

                              onPressed: () {
                                controller.handleSignIn();
                              },
                            ),
                          ),)
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(

                  bottom: 60,
                  child: DotsIndicator(
                    position: controller.state.index.value.toInt(),
                    dotsCount: 3, reversed: false,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                      size: Size.square(9),
                      activeSize: Size(18.0,9.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),

                  ))
            ],
          ),

        ))
    );
  }
}

