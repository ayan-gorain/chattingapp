import 'package:chatapp/Pages/welcome%20page.dart';
import 'package:chatapp/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppPages{
  static const INITIAL=AppRoutes.INITIAL;
  static const APPlication=AppRoutes.Application;
  static final RouteObserver<Route> observer =RouteObserver();
  static List<String> history =[];

  static final List<GetPage> routes =[
    GetPage(name: AppRoutes.INITIAL,
        page: ()=>Welcomepage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority:1)
      ]

    )



  ]


}