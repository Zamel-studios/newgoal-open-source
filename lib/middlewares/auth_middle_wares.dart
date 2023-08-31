import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; 
import '../main.dart';


//IN THIS CLASS WE CHECK WHETHER THE USER IS SIGNED IN OR NOT
class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (userDataPreference.getString("first_install") == "true") {
      Get.offAllNamed("/launcher");
      return RouteSettings(name: "/launcher");
    } else {
      Get.offAllNamed("/on_boarding");
    }

    // if(sharedPref!.getString(""))
    // if (on_boarding_shared_pref!.getString("first_install") == "true") {
    //   // return RouteSettings(name: "/launcher");
    //   Get.offAllNamed("/launcher");
    //   //returned route
    // } else {
    //   Get.offAllNamed("/on_boarding");
    // }
  }
}
