import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../constants/hot_links.dart';
import '../ui/widgets/sack_bars.dart';
import '../db/sql.dart';
import '../main.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Crud crud = new Crud();
  final isInternetConnected = false.obs;
  void checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      isInternetConnected.value = true;
    } else {
      isInternetConnected.value = false;
      print('No internet :( Reason:');
      print(InternetConnectionChecker().checkInterval);
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkInternet();
  }

  void onSubmitLogin(String? email, String? password) async {
    try {
      var response = await postRequest(
          loginLink, {"email": "$email", "password": "$password"});

      if (response['status'] == "success") {
        userDataPreference.clear(); //CLEAR PREVIOUS USER DATA
        userDataPreference.setString("id", response['data']['id'].toString());
        print(userDataPreference.getString("id"));

        userDataPreference.setString(
            "name", response['data']['name'].toString());
        print(userDataPreference.getString("name"));

        userDataPreference.setString(
            "email", response['data']['email'].toString());
        print(userDataPreference.getString("email"));

        userDataPreference.setString(
            "password", response['data']['password'].toString());
        print(userDataPreference.getString("password"));

        userDataPreference.setString(
            "is_certefied", response['data']['is_certefied'].toString());
        print(userDataPreference.getString("score"));

        userDataPreference.setString(
            "gender", response['data']['gender'].toString());
        print(userDataPreference.getString("gender"));

        userDataPreference.setString(
            "is_subscribed", response['data']['is_subscribed'].toString());
        print(userDataPreference.getString("is_subscribed"));

  userDataPreference.setString(
            "field", response['data']['field'].toString());
        print(userDataPreference.getString("field"));
        //NAVIGATE TO OTHER PAGE
        Get.appUpdate();
        Get.offNamed("/launcher");
      } else {
        customSnackBar("41".tr);
      }
      return response;
    } catch (e) {
      print(e);
    }
  }
}
