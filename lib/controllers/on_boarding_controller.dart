import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/on_boarding_model.dart';
import '../main.dart';

///
class OnBoardingController extends GetxController {
  var onPageIndex = 0.obs;
  bool get isLastPage => onPageIndex.value == onBoardingPages.length - 1;
  var pageController = PageController();

// VideoPlayerController.asset("assets/videos/rating_vid.mp4")
//         ..initialize().then((_) {}),

  // VideoPlayerController.asset("assets/videos/community_vid.mov")
  //             ..initialize().then((_) {}),

  //  VideoPlayerController.asset("assets/videos/analytics_vid.MOV")
  //             ..initialize().then((_) {}),

  //THIS ON BOARDING WILL CONTAIN THREE PAGES : 1ST: NAME, AGE,,2ND : HABITS,FIELD  3RD: WEIGHT, TALL
  List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
        "Your personal info ", "Name and age helps other people to know you "),
    OnBoardingModel("Lets make a diet",
        "insert your tall and weight to keep track your health"),
    OnBoardingModel("What is your field of interest ",
        "What habits you want to gain and what is your field of interest you have"),
  ];

  @override
  void onInit() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.notification,
    ].request();
    print(statuses[Permission.location]);

    if (await Permission.speech.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    super.onInit();
  }

  void AskForPermissions() async {
    // PermissionStatus storage = await Permission.storage.request();
    PermissionStatus notification = await Permission.notification.request();

    // if (storage != PermissionStatus.granted) {
    //   openAppSettings();
    // }

    if (notification != PermissionStatus.granted) {
      openAppSettings();
    }

    // if (storage == PermissionStatus.denied ||
    //     notification == PermissionStatus.denied) {
    //   return;
    //   //stops operation and dosnt read the nect line...
    // }
  }

  //IN THIS FUNCTION WE SET THE SHAREDPREF VARIABLE TO TRUE SO ONCE THE USER IS FINISHED FROM BOARDING PAGE HE CAN NVER SEEE IT EXCEPET IF DELETED
  void forward(index, String name, String age, String weight, String tall,
      String field, String habit, context) {
    if (isLastPage) {
      if (name != "" &&
          age != "" &&
          weight != "" &&
          tall != "" &&
          field != "" &&
          habit != "") {
        userDataPreference.setString("name", name);
        userDataPreference.setString("age", age);
        userDataPreference.setString("weight", weight);
        userDataPreference.setString("tall", tall);
        userDataPreference.setString("habit", habit);
        userDataPreference.setString("field", field.toString());
        userDataPreference.setString("first_install", "true");
        print("is fieeeeeeeeeeeeeeeeeeld :$field");
        print("yayyyy doneeeeeeeeeeee");
        Get.offAndToNamed('/launcher');
        AskForPermissions();
      } else {
        SnackBar snackBar = SnackBar(
          content: Text("fields cannot be empty !"),
          backgroundColor: Color.fromARGB(119, 255, 255, 255),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.linear);
    }
  }
}
