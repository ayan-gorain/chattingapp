import 'package:chatapp/Pages/welcome/state.dart';
import 'package:chatapp/routes.dart';
import 'package:get/get.dart';
import '../../common/store/config.dart';

class welcomeController extends GetxController{
  final state = WelcomeState();
  welcomeController();
  changePage(int index) {
    state.index.value=index;
  }
  handleSignIn() {

    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }


  
}