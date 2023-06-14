import 'package:chatapp/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'Pages/SignIn/bindings.dart';
import 'Pages/SignIn/view.dart';
import 'Pages/welcome/bindings.dart';
import 'Pages/welcome/view.dart';



class AppPages{
  static const INITIAL=AppRoutes.INITIAL;
  static const APPlication=AppRoutes.Application;
  static final RouteObserver<Route> observer =RouteObserver();
  static List<String> history =[];

  static final List<GetPage> routes =[
    GetPage(name: AppRoutes.INITIAL,
        page: ()=>WelcomePage(),
      binding: WelcomeBinding(),
    ) ,
    GetPage(name: AppRoutes.SIGN_IN,
        page: ()=>SignInPage(),
      binding: SignInBinding(),
    )



  ];


}