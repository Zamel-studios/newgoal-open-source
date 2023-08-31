import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/community_controller.dart';
import '../../models/comments_model.dart';
import '../../models/posts.dart';
import '../../models/user.dart';
import '../../constants/hot_links.dart';
import 'bottom_sheets.dart';

class SocialPostTile extends StatelessWidget {
  const SocialPostTile();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SocialMediaPostTile extends StatelessWidget {
  final Size size;
  final int index;

  final PostData postData;
  SocialMediaPostTile({
    required this.size,
    required this.postData,
    required this.index,
  });
  UserData userData = UserData();
  final communityController = Get.lazyPut(() => CommunityController());
  final CommunityController _controller = Get.find();

  ScrollController _scrollController =
      ScrollController(); //for tracking the scrollabuity of the list view so it will be added to a listF
  @override
  Widget build(BuildContext context) {
    //THIS IS THE OVEALL STRUCTURE OF A POST TILE
    //HERE WE RECEIVE THE POST DATA SO WE SET THE DATA IN EACH PLACE
    //NOTICE THAT USER ID IS ALSO PASSED TROUUGH THE APT SO WE CAN RETRIEVE EACH USERS DATA

    return Container(
        width: size.width * 0.9,
        // height: 500,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(19, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 2.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: FutureBuilder(
          future: _controller.retriveUsers(postData.userId.toString()),
          builder: ((BuildContext context, AsyncSnapshot snapshot) {
            if (!(snapshot.hasData)) return Container();
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator.adaptive();
            if (snapshot.hasData) {
              userData = UserData.fromJson(snapshot.data['data'][0]);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage("images/share_care.gif"),
                      ),
                      Expanded(
                          // flex: 4,
                          child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData.name.toString(),
                                style: TextStyle(
                                  color: white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                postData.postDate!.toString(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 193, 188, 188),
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ).paddingAll(8),
                          snapshot.data['data'][0]['is_subscribed'] == "yes"
                              ? Image.asset(
                                  "images/verified_ic.png",
                                  width: 25,
                                )
                              : Container(),
                        ],
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: white,
                        ),
                        onPressed: () {
                          //ONCE THE MENU IS CLICKED THERE WEILL BE TOW OPTIONS: REPORT, SAVE POST
                          //REPORT SECTION WILL SHOW YOU LIST OF REPORT TYPES THEN YOU WILL REPORT A POST ACCORDING TO THE CAUSE
                          _controller.showCustomMenuPopUp(
                              context, int.parse(postData.postId!));
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    postData.postDescription!.toString(),
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  postData.postImg != "no-img"
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage(
                              placeholder: AssetImage("images/loading_img.gif"),
                              image: NetworkImage(
                                  "${linkImageName}/${postData.postImg.toString()}")),
                        )
                      : Container(),
                  SizedBox(height: 12.0),
                  Row(
                    ///comment and like buttons
                    children: [
                      Expanded(
                        child: Material(
                          color: Color.fromARGB(139, 131, 10, 201),
                          borderRadius: BorderRadius.circular(20),
                          elevation: 2.0,
                          animationDuration: Duration(milliseconds: 2000),
                          child: InkWell(
                            splashColor: Colors.red,
                            // highlightColor: Colors.red,
                            onTap: () {
                              commentsBottomSheetDialog(
                                  context, postData.postId);
                            },
                            child: FutureBuilder(
                              future:
                                  _controller.retriveComments(postData.postId),
                              builder: (BuildContext comment_context,
                                  AsyncSnapshot snapshot_comment) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  if (!(snapshot.hasData)) {
                                    // Future.delayed(Duration(seconds: 7));
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: green_c,
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (!(snapshot.hasData)) {
                                  // Future.delayed(Duration(seconds: 7));
                                  return Center(
                                    child: Text(
                                      "No posts try connecting to internet!",
                                      style: TextStyle(
                                          color: white_c, fontSize: 20),
                                    ),
                                  );
                                }
                                if (snapshot_comment.hasData) {
                                  return Container(
                                    height: 45,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "images/coment_ic.png",
                                          height: 25,
                                        ),
                                        Text(
                                          "Add your comment",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  215, 238, 237, 237)),
                                        ).paddingOnly(left: 8, right: 8),
                                        Expanded(child: Container()),
                                        Text(
                                          snapshot_comment
                                                      .data['comments_count'] !=
                                                  null
                                              ? "  ${snapshot_comment.data['comments_count']} comments"
                                              : " 0  comments",
                                          style: TextStyle(color: white),
                                        ).paddingAll(5)
                                      ],
                                    ).paddingAll(10),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ).paddingAll(5),
                      ),
                      SizedBox(width: 10.0),
                      // InkWell(
                      //   onTap: () {
                      //     _controller.likePost(
                      //         int.parse(postData.userId.toString()),
                      //         index,
                      //         postData);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       postData.isLiked != true
                      //           ? IconButton(
                      //               icon: Icon(
                      //                 Icons.favorite_border,
                      //                 color: white,
                      //               ),
                      //               onPressed: () {
                      //                 // Handle like button tap
                      //               },
                      //               iconSize: 25,
                      //             )
                      //           : IconButton(
                      //               icon: Icon(
                      //                 Icons.favorite_border,
                      //                 color: red_c,
                      //               ),
                      //               onPressed: () {
                      //                 // Handle like button tap
                      //               },
                      //               iconSize: 25,
                      //             ),
                      //       Text(
                      //         "29 likes",
                      //         style: TextStyle(color: white),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              );
            }

            return Center(
              child: Text("No data"),
            );
          }),
        ));
  }
}

class CommentsCard extends StatelessWidget {
  final CommentsModel comments_model;
  final post_id;
  final index;

  ///MADE THIS AR TO GET THE  POST DATA LIKE USERNAME USERIMAGE....
  const CommentsCard({required this.comments_model, this.post_id, this.index});

  @override
  Widget build(BuildContext context) {
    final CommunityController community_controller = Get.find();
    // UsersDataModel usersDataModel ;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        //WE PASSED THE POST ID THEN WE GOT THE USERS ID THEN PASS IT TO GET THE DATA OF EACH USER RATHER THAN GETTING IT DIRECTLY FROM THE COMMENTS SECTION
        future: community_controller
            .retriveUsersDataComment("${comments_model.commenterId}"),
        // List<PostD>_commentsList=snapshot.data['data'].map
        // List<CommentsModel> comments_List = snapshot.data['data']
        //     .map<CommentsModel>(
        //         (comment_data) => CommentsModel.fromJson(comment_data))
        //     .toList();
        // usersDataModel=UsersDataModel.fromJson(snapshot.data['data'][1]);

        ///GET USERS DATA BY ID
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          // usersDataModel=UsersDataModel.fromJson(snapshot.data['data'][1]);
          if (snapshot.connectionState == ConnectionState.waiting) {
            if (!(snapshot.hasData)) {}
          }
          if (snapshot.hasData) {
            return CommentsTile(
              commentsModel: comments_model,
              usersDataModel_name: UserData.fromJson(snapshot.data['data'][0]),
              usersDataModel_profile_img:
                  UserData.fromJson(snapshot.data['data'][0]),
            );
          }
          return SizedBox();
        }));
  }
}

class CommentsTile extends StatelessWidget {
  final CommentsModel commentsModel;
  final UserData usersDataModel_name;
  final UserData usersDataModel_profile_img;
  const CommentsTile({
    Key? key,
    required this.commentsModel,
    required this.usersDataModel_profile_img,
    required this.usersDataModel_name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.95,
          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(41, 255, 255, 255)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: size.width * 0.10,
                    height: size.height * 0.08,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CircleAvatar(
                      backgroundColor: white_c,
                      // backgroundImage: AssetImage(randImage()),
                      radius: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${usersDataModel_name.name}",
                        style: TextStyle(
                            color: white_c,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        "${commentsModel.commentDate}",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(237, 218, 215, 215),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.07, right: size.width * 0.07),
                width: size.width * 0.6,
                child: Text(
                  "${commentsModel.commentDescription}",
                  style: TextStyle(color: Color.fromARGB(237, 218, 215, 215)),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTextFormField2 extends StatelessWidget {
  final String hint;
  final TextInputType type;
  final Color color;
  final TextEditingController controller;
  final String? Function(String?) valid;
  final Function()? click_send;
  const CustomTextFormField2({
    Key,
    required this.hint,
    required this.type,
    required this.color,
    required this.controller,
    required this.valid,
    required this.click_send,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      width: context.width,
      height: context.height * 0.07,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        validator: valid,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(7),
            suffixIcon: InkWell(
              child: Icon(
                Icons.send_rounded,
                color: pupple_c,
              ),
              onTap: () {
                click_send!();
              },
            ),
            // contentPadding: EdgeInsets.all(20),
            border: InputBorder.none,
            hintText: hint,
            errorStyle: TextStyle(fontSize: 7),
            hintStyle: TextStyle(
                color: hint_text_color,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip)),
      ),
    );
  }
}

Widget LoginCenterWidget(size) {
  return Container(
    margin: EdgeInsets.only(top: size.height * 0.15),
    alignment: Alignment.center,
    width: size.width * 0.7,
    height: size.height * 0.5,
    decoration: BoxDecoration(
        border: Border.all(color: white, width: 2),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Color.fromRGBO(64, 18, 139, 1),
          Color.fromRGBO(147, 54, 180, 1)
        ])),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/login_sammy.png",
            width: size.width * 0.2,
            height: size.height * 0.16,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text(
              "44".tr,
              style: TextStyle(
                color: white_c,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: size.width * 0.6,
            height: 45,
            decoration: BoxDecoration(
                border: Border.all(color: white_c),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                  Color.fromRGBO(64, 18, 139, 1),
                  Color.fromRGBO(147, 54, 180, 1)
                ])),
            child: IconButton(
                onPressed: () {
                  try {
                    Get.offNamed("/login");
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: white_c,
                  size: 30,
                )),
          )
        ],
      ),
    ),
  );
}
