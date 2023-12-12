
import 'package:chatapp/pages/SignIn.dart';
import 'package:chatapp/pages/welcomepage.dart';



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import 'firebase_options.dart';
import 'model/chat_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase(); // Initialize Firebase first
  setPreferredOrientations(); // Set preferred device orientations
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  try {
    // Ensure Firebase is initialized only if it's not already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle initialization error appropriately
  }
}

void setPreferredOrientations() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
          home:welco() ,

          // debugShowCheckedModeBanner: false,
          // routes: {
          //   "/": (context) =>about(user: Chatuser(name: "",image: "")),
          //   MyRoutes.SigninRoute:(context)=>Signnn(),
          //   MyRoutes.welcoRoute:(context)=>welco(),
          //   MyRoutes.navRoute:(context)=>Nav(),
          //   MyRoutes.userRoute:(context)=>about(user: list[1],),
          //
          //
          //
          //
          // },
        );
      },
    );
  }
}
