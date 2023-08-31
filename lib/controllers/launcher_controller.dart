

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/pages/community.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/profile.dart';

import '../ui/pages/analytics.dart';
import '../utilities/bindings.dart';

class LauncherController extends GetxController {
  static LauncherController get to => Get.find();
  var currentIndex = 0.obs;
  //makes it observable
  final pages = <String>['/home', '/charts', '/community', '/profile'];
 
  void changePage(int index) {
    currentIndex.value = index;
    Get.offNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/home')
      // ignore: curly_braces_in_flow_control_structures
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: AddTaskBinding(),
      );
    if (settings.name == '/charts') {
      return GetPageRoute(
        settings: settings,
        page: () => Analytics(),
        binding: AnalyticsBinding(),
      );
    }

    if (settings.name == '/community')
      // ignore: curly_braces_in_flow_control_structures
      return GetPageRoute(
        settings: settings,
        page: () => Community(),
        binding: CommunityBinding(),
      );

    if (settings.name == '/profile')
      // ignore: curly_braces_in_flow_control_structures
      return GetPageRoute(
        settings: settings,
        page: () => Profile(),
        binding: ProfileBinding(),
      );

    return null;
  }
}
