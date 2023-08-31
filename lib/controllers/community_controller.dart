import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/hot_links.dart';
import '../db/sql.dart';
import '../models/posts.dart';
import '../ui/widgets/bottom_sheets.dart';
import '../constants/colors.dart';
import '../constants/bad_wrods_english.dart';
import '../main.dart';
import '../ui/widgets/alert_dialogs.dart';

class CommunityController extends GetxController {
  // late List<PostData> _postDataList;

  int current_page = 1;
  final isInternetConnected = true.obs;
  final isVerifiedAccount = false.obs;
  final isLogin = false.obs;

  @override
  void onInit() async {
    controller = TextEditingController();
    // print("${sharedPref!.getString("id")}");
    if (userDataPreference.getString("id") != null) {
      //user is signed in
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }

    super.onInit();
  }

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

  void openCamerWithFocus(my_file, setState, file_path) async {
    PermissionStatus photos = await Permission.camera.request();
    if (photos != PermissionStatus.granted) {
      openAppSettings();
    }
    //HERE WE OPEN GALLERY OR CAMERA TO ADD IMAGE
    XFile? xFileCamera =
        await ImagePicker().pickImage(source: ImageSource.camera);
    my_file = File(xFileCamera!.path);
    setState((() {
      file_path = my_file!.path;
    }));
  }

  // "is_subscribed":
  //     "${userDataPreference.getString("is_subscribed")}",
  // "user_id":
  //     "${userDataPreference.getString("id")}",
  // "post_img": "",
  // "post_description":
  //     "${post_description_controller.text.toString()}",
  // "post_date": "$_currentDate",
  // "shared_task": " ",
  // "post_field":
  //     "${userDataPreference.getString("field")}"

  
  //THIS FUNCION IS FOR UPLOADING A POST TO THE DB
  Future addPost(String _currDate,String post_description_controller, BuildContext context) async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      if (userDataPreference!.getString("id") != null) {
        // GetCurrentUserData currentUserData = new GetCurrentUserData();
        // currentUserData. getCurrentUserData();
        ///get users data to send it when comment is  dones

        var response = await postRequest(addPostLink, {
          "is_subscribed": "${userDataPreference.getString("is_subscribed")}",
          "user_id": "${userDataPreference.getString("id")}",
          "post_img": "no img",
          "post_description": "${post_description_controller}",
          "post_date": "$_currDate",
          "shared_task": " ",
          "post_field": "${userDataPreference.getString("field")}"
        });

        //CHECK IF SUBSCRIBED
        if (response['is_subscribed'] != 'yes') {
          //CHECK IF ITS DONE SUCCEFULLY
          if (response['status'] == "success") {
            print("done------------");
          } else {
            print("not done -------------");
            return;
          }
        }

        if (response['is_subscribed'] == "yes") {
          print("no mucho habla espanol");
          Dialogs _dialog = Dialogs();
          // ignore: use_build_context_synchronously
          _dialog.dialog_Membership_Warning(
            context,
            "images/membership_gif.gif",
            "Please try to subscribe to the membership so you can post and comment freely.",
            "You have reached your maximum comments!",
          );
        }

        return response;
      } else {
        Get.toNamed("/login");
      }
      // else {
      //   print("imggggggggggggggggggggggggg dosnt exists");
      //   //do something if img was not existing
      //   var response = await postRequestWithFile(addPostLink, image_path_n, {
      //     "user_name_n": "user_name_n",
      //     "user_score_n": "5656",
      //     "post_date_n": "${_year} / ${_month} / ${_day}",
      //     "description_n": "description_n",
      //     "user_id_n": "${sharedPref!.getString('id')}"
      //   });
      //   print("done------------");

      //   // if (response['limit'] == "max_posts") {
      //   //   // ignore: use_build_context_synchronously
      //   //   dialog_Membership_Warning(
      //   //     context,
      //   //     "images/membership_gif.gif",
      //   //     "Please try to subscribe to the membership so you can post and comment freely.",
      //   //     "You have reached your maximum comments!",
      //   //   );
      //   // }
      //   return response;
      // }
    } else {
      Get.defaultDialog(
          backgroundColor: pupple_c,
          content: Container(
            child: Image.asset(
              "images/no_internet_ic.png",
              width: 50,
            ),
          ),
          middleText: "Try connecting to wifi or turn on mobile data",
          title: "No internet",
          titleStyle: TextStyle(color: white_c));
      return;
    }
  }
  //v M C
  void show_internet_dialog() {
    Get.defaultDialog(
        backgroundColor: pupple_c,
        content: Container(
          child: Image.asset(
            "images/no_internet_ic.png",
            width: 50,
          ),
        ),
        middleText: "Try connecting to wifi or turn on mobile data",
        title: "No internet",
        titleStyle: TextStyle(color: white_c));
  }

  Future retrivePosts() async {
    var response = await postRequest(postsLink ,
        {'post_field': '${userDataPreference.getString("field")}'});

    print("posts are fetched !");
    return response;
  }

  /// -------------------------------
  /// |REPORT_ID | REPORTER_ID | REPORT_TYPE |  POST_ID  |
  ///

  Future retriveUsers(uid) async {
    var response = await postRequest(usersDataLink.toString(), {"id": uid});
    print("users are fetched !");
    return response;
  }

  Future retriveUsersDataComment(commenter_id) async {
    var response =
        await postRequest(usersDataLink.toString(), {"id": '${commenter_id}'});
    if (response['status'] == 'success') {
      print("DATA is retrived succefully !");
    } else {
      print("no DATA retrived");
    }

    return response;
  }

  Future retriveComments(post_id) async {
    var response = await postRequest(commentsLink.toString(),
        {"current_post_id": "${int.parse(post_id).toString()}"});
    if (response['status'] == 'success') {
      print("comments are retrived succefully !");
    } else {
      print("no comments retrived ********");
    }

    return response;
  }

  Future retriveCommentsCount(post_id) async {
    var response = await postRequest(commentsCountLink.toString(),
        {"current_post_id": "${int.parse(post_id).toString()}"});

    return response;
  }

  void showCustomMenuPopUp(BuildContext context, int post_id) {
    showMenu(
      color: bluishClr,
      elevation: 5,
      context: context,
      position: RelativeRect.fromLTRB(
        100, // left
        200, // top
        0, // right
        0, // bottom
      ),
      // Pass the current BuildContext
      // position: RelativeRect.fromLTRB(
      //     1, 1, 0, 0), // Adjust the position of the menu if needed
      items: [
        PopupMenuItem(
          textStyle: TextStyle(color: white),
          value: 'Save post',
          child: Row(
            children: [
              Icon(
                Icons.save,
                color: white,
              ).paddingAll(5),
              Text('Save post')
            ],
          ),
          onTap: () {
            // Handle item 1 selection
          },
        ),
        PopupMenuItem(
          textStyle: TextStyle(color: white),
          value: 'Report post',
          child: Row(children: [
            Icon(Icons.report, color: white).paddingAll(5),
            Text('Report post')
          ]),
          onTap: () {
            Get.defaultDialog(
                backgroundColor: bluishClr,
                content: Column(
                  children: [
                    menuItemReports(post_id, "Sexual content", context),
                    menuItemReports(post_id, "Spam / scam", context),
                    menuItemReports(post_id, "Terrorism", context),
                    menuItemReports(post_id, "Racism", context),
                  ],
                ));
          },
        ),
      ],
    );
  }

  PopupMenuItem menuItemReports(int post_id, String report_type, context) {
    return PopupMenuItem(
      textStyle: TextStyle(color: white),
      value: report_type,
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: white,
          ).paddingAll(5),
          Text('$report_type')
        ],
      ),
      onTap: () {
        ///REPORT POST
        reportPost(post_id, report_type, context);
      },
    );
  }

  Future reportPost(int post_id, String report_type, context) async {
    var response = await postRequest(reportPostLink.toString(), {
      'post_id': '${post_id.toString()}',
      'reporter_id': '60', //this is gotten from shared preferences
      'report_type': '$report_type'
    });

    if (response['is_reported'] == 'true') {
      Dialogs _dialog = Dialogs();
      _dialog.success_dialog("Successfully reported user !", context,
          "User has been reported to the admin", "images/success_dialog.gif");
    }

    return response;
  }

  void likePost(int post_id, int index, PostData model) {
    // model.isLiked = true;
    print("its liked $post_id");
  }

  void sendComments(context, get_post_id_comments) async {
    String _comment_description = controller.text;
    int _year = DateTime.now().year;
    int _month = DateTime.now().month;
    int _day = DateTime.now().day;
    // Crud crud = Crud();
    bool bad_word = false;

    ///INITILIZING VARIABLES
    ///
    ///
    ///
    //CHECK BAD WORDS HERE...
    if (_comment_description != "") {
      for (int i = 0; i < bad_words.length; i++) {
        ///was bad_words.length
        if (_comment_description.contains(bad_words[i])) {
          bad_word = true;
        }
      }

      //IF THERE IS BAD WORDs
      if (bad_word == true) {
        membership_warningBottomSheetDialog(context, "images/warning_gif.gif",
            "No bad words are allowed", "Please watch your language");
      }

      // IF THERE IS NO BAD WORDs
      if (bad_word == false && controller.text != "") {
        var response = await postRequest(addCommentLink, {
          "commenter_id": "60",
          "comment_description": "${_comment_description.toString()}",
          "post_id": "$get_post_id_comments", // BROUGHT BY PARAMETER
          "comment_date": "${_year}/${_month}/${_day}"
        });

        //IF COMMENT  IS SUCCEFULLY  ADDED
        if (response['status'] == "success") {
          controller.text = "";
          print('mabrouk');
        }

        ///CHECHK MEMBERSHIP
        if (response['limit'] == "max_comments") {
          Size size = MediaQuery.of(context).size;
          print("maxxxxxxxxxxxx");
          // dialog_Membership_Warning(
          //   context,
          //   "images/membership_gif.gif",
          //   "Please try to subscribe to the membership so you can post and comment freely.",
          //   "You have reached your maximum comments!",
          // );
        }
      }
    }
    // else {
    //   Get.snackbar("Empty field", "You have to write a comment !",
    //       colorText: red_c);
    // }
  }
}
