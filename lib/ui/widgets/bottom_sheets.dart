import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/community_controller.dart';
import '../../models/comments_model.dart';
import '../../ui/widgets/community_widgets.dart';

TextEditingController controller = TextEditingController();
final CommunityController _community_controller = Get.find();

void commentsBottomSheetDialog(
  BuildContext context,
  get_post_id,
) {
  // bool nopost = false;
  // String get_post_id_comments = get_post_id;
  // print(get_post_id_comments);
  // BuildContext buildContext =BuildContext();
  //RETRIVE COMMENTS BY POST ID
  //THE CARD OF COMMENTS PAGE IS IN THE BIG COMPONENTS FILE
  Size size = MediaQuery.of(context).size;
  Get.bottomSheet(StatefulBuilder(builder: (context, setState) {
    onDelete() {
      setState(
        () {
          controller.text = "";
        },
      );
    }

    onClose() {
      setState(
        () {
          controller.text = "";
        },
      );
    }

    //COMMENTS RETRIEVING
    return Container(
        padding: EdgeInsets.all(1),
        height: size.height * 0.8,
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(64, 18, 139, 1),
              Color.fromRGBO(147, 54, 180, 1)
            ])),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _community_controller
                    .retriveComments(get_post_id), //get_post_id_comments
                builder: ((BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.hasData) {
                    // print(
                    //     '${snapshot.data['data']['comment_description']} -----------------');
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              reverse: false,
                              addAutomaticKeepAlives: true,
                              addRepaintBoundaries: true,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (BuildContext context, index) {
                                // print(snapshot.data['data']['current_post_id_n'][index].toString());
                                return CommentsCard(
                                  comments_model: CommentsModel.fromJson(
                                      snapshot.data['data'][index]),
                                  post_id: get_post_id,
                                  index: index,
                                );
                              }),
                        ),
                      ],
                    );
                  }
                  return snapshot.data != null
                      ? Center(child: const CircularProgressIndicator())
                      : Center(
                          child: Text(
                            'There is no comments',
                            style: TextStyle(color: white_c),
                          ),
                        );
                  // return nopost == true
                  //     ? const Center(
                  //         child: Text("NO comments"),
                  //       )
                  //     : const Center();
                }),
              ),
            ),
            Container(
              width: size.width * 0.9,
              margin: const EdgeInsets.all(5),
              height: 50,
              child: CustomTextFormField2(
                click_send: () {
                  setState(
                    () {
                      _community_controller.sendComments(context, get_post_id);
                    },
                  );
                },
                hint: "Type your comment...",
                type: TextInputType.name,
                color: Color.fromARGB(255, 255, 255, 255),
                controller: controller,
                valid: (g) {},
              ),
            )
          ],
        ));
  }));
}

void membership_warningBottomSheetDialog(context, img_link, main_text, title) {
  Size size = MediaQuery.of(context).size;
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(60)),
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
