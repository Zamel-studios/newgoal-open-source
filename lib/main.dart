import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/db_helper.dart';
import '../db/local.dart';
import '../services/theme_services.dart';
import '../ui/auth/login_page.dart';
import '../ui/pages/analytics.dart';
import './ui/pages/community.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/launcher.dart';
import '../ui/pages/on_boarding_screen.dart';
import '../ui/pages/profile.dart';
import '../ui/theme.dart';
import '../utilities/bindings.dart';

late SharedPreferences   userDataPreference, sharedPrefLikes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  userDataPreference = await SharedPreferences
      .getInstance(); //THIS PREFERENCE HOLDS THE USER DATA SUCH AS EMAIL, NAME, WEIGHT , TALL...
   
  // sharedPrefBoarding = await SharedPreferences.getInstance();
  sharedPrefLikes = await SharedPreferences.getInstance();
  // MainFunctions().isThereNewUpdate();

  // mainFunctions.prefrences_init(sharedPrefLogin, sharedPrefBoarding);
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}
////MATERIAL CLASS
///
///

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(//material app
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      locale: Get.deviceLocale,
      themeMode: ThemeService().theme,
      translations: TranslationLocal(),
      initialRoute:  userDataPreference.getString("first_install") == "true"
          ? "/launcher"
          : "/on_boarding",
      getPages: [
        GetPage(name: "/login", page: () => Login(), binding: LoginBinding()),
        GetPage(
            name: '/launcher',
            page: (() => LauncherPage()),
            binding: LauncherBindings()),
        GetPage(
          name: '/home',
          page: (() => HomePage()),
          binding: HomeBindings(),
          // middlewares: [AuthMiddleWare()
          // ]
        ),
        GetPage(
          name: '/analytics',
          page: (() => Analytics()),
          binding: AnalyticsBinding(),
          // middlewares: [AuthMiddleWare()
          // ]
        ),
        GetPage(
          name: '/community',
          page: (() => Community()),//UI
          binding: CommunityBinding(),
          // middlewares: [AuthMiddleWare()
          // ]
        ),
        GetPage(
          name: '/profile',
          page: (() => Profile()),
          binding: ProfileBinding(),
          // middlewares: [AuthMiddleWare()
          // ]
        ),
       
        GetPage(
            name: "/on_boarding",
            page: (() => OnBoardingScreen()),
            binding: OnBoardingBinding()),
            //  GetPage(
            // name: "/signup",
            
            // page: (() => 
            // ()),
            // binding: OnBoardingBinding()),
          
          
      ],
    );
  }
}
