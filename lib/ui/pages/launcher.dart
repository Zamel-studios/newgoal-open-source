import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/launcher_controller.dart';
import '../theme.dart';
import '../widgets/custom_nav_bar_item.dart';

class LauncherPage extends StatelessWidget {
  const LauncherPage();

  @override
  Widget build(BuildContext context) {
    LauncherController controller = Get.find();
    return Scaffold(
        extendBody: true,
        //this feature allows you to put any thing beyhind navbar
        bottomNavigationBar: Obx(
          () => Padding(
            padding: const EdgeInsets.all(10),
            child: CustomNavigationBar(
              bubbleCurve: Curves.linear,
              isFloating: true,
              backgroundColor: primaryClr,
              //elevation: 10,
              borderRadius: Radius.circular(15),
              scaleCurve: Curves.bounceIn,
              //blurEffect: true,
              selectedColor: pupple_c,
              currentIndex: controller.currentIndex.value,

              onTap: controller.changePage,
              items: [
                ///hh
                CustomNavBarItem(
                    "32".tr,
                    true,
                    1,
                    Icon(
                      Icons.home,
                      color: white_c,
                    ),
                    "32".tr),
                CustomNavBarItem("33".tr, true, 1,
                    Image.asset('images/charts.png'), "33".tr),
                CustomNavBarItem("34".tr, true, 1,
                    Image.asset('images/community.png'), "34".tr),
                CustomNavBarItem("35".tr, true, 1,
                    Icon(Icons.person, color: white_c), "35".tr)
              ],
            ),
          ),
        ),
        body: Container(
          color: Color.fromRGBO(147, 54, 180, 1),
          width: double.infinity,
          height: double.infinity,
          child: Navigator(
            key: Get.nestedKey(1),
            initialRoute: "/home",
            onGenerateRoute: controller.onGenerateRoute,
          ),
        ));
  }
}
