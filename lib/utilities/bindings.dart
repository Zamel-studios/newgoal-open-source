import 'package:get/get.dart';
import '../controllers/analytics_controller.dart';
import '../controllers/community_controller.dart';
import '../controllers/launcher_controller.dart';
import '../controllers/login_page_controller.dart';
import '../controllers/on_boarding_controller.dart';

import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/task_controller.dart';


//HERE IN THIS CLASS WE CONNECT THE CONTROLLERS PAGES WITH THE PAGES INTERFACES 
///THIS CLASS IS USAUALLY CALLED IN THE MAIN FUNCTION
//implements ...ALLOWS YOU TO CALL ALL METHODS INSIDE THE CLASS
//lazyput is recomended than   put when using intial method so it wont be calld for the whole classes
//calling bindings =>calls its own controllers and this might cause an error damaging classes and making lags

class LauncherBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LauncherController(), fenix: true);
  }
}

class AnalyticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => AnalyticsController()), fenix: true);
  }
}
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => LoginController()), fenix: true);
  }
}


class CommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => CommunityController()), fenix: true);
  }
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => ProfileController()), fenix: true);
  }
}

class AddTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => HomeController()), fenix: true);
  }
}
class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => HomeController()), fenix: true);
  }
}


class OnBoardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingController(), fenix: true);
  }
}
