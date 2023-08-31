import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import '../../constants/colors.dart';
import '../../constants/hot_links.dart';
import '../../controllers/task_controller.dart';
import '../../main.dart';
import '../../ui/widgets/input_field.dart';

import '../../constants/bad_wrods_english.dart';
import '../../controllers/community_controller.dart';
import '../../db/sql.dart';
// import 'package:task_management/models/comments.dart';

class Dialogs {
  late Size size;
  void success_dialog(String success_msg, BuildContext context,
      String description, String img_link) {
    final HomeController _controller = Get.find();
    size = MediaQuery.of(context).size;

    Get.defaultDialog(
        titlePadding: EdgeInsets.all(30),
        // textCustom: "",custom: Icon(Icons.alarm),
        // title: "helllllllllllllll",
        // textCancel: "",
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                Color.fromRGBO(64, 18, 139, 1),
                Color.fromRGBO(147, 54, 180, 1)
              ])),
          width: size.width * 0.7,
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Image.asset(
                img_link,
                width: size.width * 0.35,
                height: size.height * 0.22,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                width: size.width * 0.5,
                child: Text(
                  success_msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white_c,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.45,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: green_c,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )

              ///
            ],
          )),
        )).then((value) => 2);
  }

  void new_update_dialog(context, img_link, main_text, title) {
    final HomeController _controller = Get.find();
    size = MediaQuery.of(context).size;
// File my_file;
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          // alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                Color.fromRGBO(64, 18, 139, 1),
                Color.fromRGBO(147, 54, 180, 1)
              ])),
          width: size.width * 0.7,
          // height: size.height * 0.7,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Image.asset(
                    img_link,
                    width: size.width * 0.35,
                    height: size.height * 0.22,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    width: size.width * 0.5,
                    child: Text(
                      main_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: white_c,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.45,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: green_c,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 50),
                      width: size.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60)),
                      child: MaterialButton(
                        onPressed: () async {
                          await _controller.launchAppUrl();
                          // final controller = Get.put(
                          //   (() => HomeController()),
                          // );
                          // HomeController homeController = Get.find();
                          // homeController.launchAppUrl();
                        },
                        color: green_c,
                        child: Text(
                          "Go",
                          style: TextStyle(
                              color: white_c, fontWeight: FontWeight.bold),
                        ),
                      )),
                ]),
          ),
        ));
  }

  void addPostDialog(
      context, TextEditingController post_description_controller) {
    final CommunityController community_controller = Get.find();
    String file_path = "";
    File? my_file;
    Size size = MediaQuery.of(context).size;
    bool bad_word = false;

    Get.defaultDialog(
        title: "",
        backgroundColor: Colors.transparent,
        content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(64, 18, 139, 1),
                  Color.fromRGBO(147, 54, 180, 1)
                ])),
            width: size.width * 0.8,
            height: size.height * .6,
            child: StatefulBuilder(
                builder: (context, setState) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 20, top: 40, right: 20),
                          child: Text(
                            "72".tr,
                            style: TextStyle(
                                color: white_c,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 30),
                            width: size.width * 0.5,
                            height: 40,
                            child: CustomTextFormField(
                                hint: "73".tr,
                                type: TextInputType.name,
                                color: white_c,
                                controller: post_description_controller,
                                valid: (l) {},
                                isPassword: false)),
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(child: Container()),
                        Center(
                          child: Column(
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //open camera
                                    InkWell(
                                      onTap: () async {
                                        //open camera
                                        community_controller.openCamerWithFocus(
                                            my_file, setState, file_path);
                                        // print(my_file!.path.toString());
                                      },
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: white_c,
                                        size: 50,
                                      ),
                                    ),
                                    //get from studio
                                    InkWell(
                                      onTap: () async {
                                        //HERE WE OPEN GALLERY OR CAMERA TO ADD IMAGE
                                        XFile? xFileCamera = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        my_file = File(xFileCamera!.path);
                                        // print(my_file!.path.toString());
                                      },
                                      child: Icon(
                                        Icons.image,
                                        color: white_c,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: size.width * 0.2,
                                child: Text(
                                  file_path == "" ? "74".tr : file_path,
                                  style:
                                      TextStyle(color: green_c, fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 70,
                            )),
                        Expanded(
                          child: Container(),
                        ),
                        //THIS FUNCTION FOR POSTING A POST
                        InkWell(
                          onTap: () async {
                            String? _currentDate = DateFormat('yyyy-MM-dd')
                                .format(DateTime.now())
                                .toString(); //GET CURRENT DATE WITH A YYYY MM DD FORMAT

                            //THIS FUCTIONS IS FOR CHECKING THE POST , IF IT HAS BAD WORDS
                            if (post_description_controller.text.isNotEmpty &&
                                post_description_controller.text.length >= 10) {
                              for (int i = 0; i < bad_words.length; i++) {
                                if (post_description_controller.text
                                    .contains(bad_words[i])) {
                                  bad_word = true;
                                }
                              }
                            } else {
                              Get.snackbar("75".tr, "76".tr);
                            }

                            //FILTER BAD WORDS
                            if (post_description_controller.text.length >= 10 &&
                                bad_word == true) {
                              return dialog_Membership_Warning(context,
                                  "images/warning_gif.gif", "77".tr, "78".tr);
                            }

                            //IF THERE IS NO BAD WORDS
                            if (bad_word == false &&
                                post_description_controller.text.length > 10 &&
                                post_description_controller.text.isNotEmpty) {
                              //IF USER POSTED AN IMAGE TOO...
                              if (my_file != null) {
                                //FUTURE UPDATE : ONCE YOU ESTABLISH THE BILLING GATE MAKE SURE TO GET UPDATED USER DATA SUCH AS
                                // IS_SUBSCRIBED BECAUSE ITS ONLY PREVIEWD IN THE SHARED PREFERENCES
                                var response = await postRequestWithFile(
                                    addPostLink, my_file, {
                                  "is_subscribed":
                                      "${userDataPreference.getString("is_subscribed")}",
                                  "user_id":
                                      "${userDataPreference.getString("id")}",
                                  "image_path": "$file_path",
                                  "post_description":
                                      "${post_description_controller.text.toString()}",
                                  "post_date": "$_currentDate",
                                  "post_field":
                                      "${userDataPreference.getString("field")}"
                                });
                                Get.back();

                                // Get.defaultDialogTransitionDuration;
                                Future.delayed(Duration(milliseconds: 500));

                                if (response['status'] == 'success') {
                                  success_dialog(
                                      "Done :)",
                                      context,
                                      "Success! Your post is out there, making waves.",
                                      "images/success_dialog.gif");
                                  post_description_controller.text = "";
                                  my_file = null;
                                  bad_word = false;
                                }
                              }
                              //IF USER DIDNT POST AN IMAGE...
                              else {
                                community_controller.addPost(_currentDate,
                                    post_description_controller.text, context);
                              }
                              post_description_controller.text = "";
                              my_file = null;
                              bad_word = false;

                              return;
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: green_c,
                                borderRadius: BorderRadius.circular(20)),
                            width: size.width * 0.3,
                            height: 40,
                            child: Text(
                              '79'.tr,
                              style: TextStyle(
                                  color: white_c, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        )
                      ],
                    ))));
  }

  void dialog_Membership_Warning(context, img_link, main_text, title) {
    Size size = MediaQuery.of(context).size;
// File my_file;
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          // alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                green_c,
                Color.fromARGB(195, 75, 6, 187),
              ])),
          width: size.width * 0.7,
          // height: size.height * 0.7,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Image.asset(
                    img_link,
                    width: size.width * 0.35,
                    height: size.height * 0.22,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    width: size.width * 0.5,
                    child: Text(
                      main_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: white_c,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.45,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: green_c,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 50),
                      width: size.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60)),
                      child: MaterialButton(
                        onPressed: () {
                          Get.back();
                          // Navigator.of(context).pop();
                        },
                        color: green_c,
                        child: Text(
                          "Go",
                          style: TextStyle(
                              color: white_c, fontWeight: FontWeight.bold),
                        ),
                      )),
                ]),
          ),
        ));
  }
}
