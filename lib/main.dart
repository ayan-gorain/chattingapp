
import 'package:chatapp/pages/SignIn.dart';
import 'package:chatapp/pages/nav.dart';
import 'package:chatapp/pages/user.dart';

import 'package:chatapp/pages/welcomepage.dart';
import 'package:chatapp/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'firebase_options.dart';

late Size mq;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 784),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use a library outside ScreenUtilInit context
      builder: (_, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) =>welco(),
            MyRoutes.SigninRoute:(context)=>Signnn(),
            MyRoutes.welcoRoute:(context)=>welco(),
            MyRoutes.navRoute:(context)=>Nav(),
            MyRoutes.userRoute:(context)=>about(),




          },
        );
      },
    );
  }
}
