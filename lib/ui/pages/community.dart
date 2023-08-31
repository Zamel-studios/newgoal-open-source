import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/community_controller.dart';
import '../../main.dart';
import '../../models/posts.dart';
import '../../ui/widgets/alert_dialogs.dart';
import '../../ui/widgets/community_widgets.dart';

class Community extends StatefulWidget {
  @override
  State<Community> createState() => _CommunitysState();
}

class _CommunitysState extends State<Community> {
  CommunityController _communityController = Get.find();
  bool showBuilder = true;
  final post_description_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          //CHECK IF INTERNET EXISTS
          //THEN CHECK IF USER IS LOGGED IN OR NOT!
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(147, 54, 180, 1),
          floatingActionButton:
              Obx(() => _communityController.isInternetConnected == true
                  ? _communityController.isLogin == true
                      ? FloatingActionButton(
                          backgroundColor: pupple_c,
                          onPressed: () {
                            Dialogs dialogs = Dialogs();
                            dialogs.addPostDialog(
                                context, post_description_controller);
                          },
                          child: const Icon(Icons.post_add),
                        )
                      : Visibility(
                          child: Container(),
                          visible: false,
                        )
                  : Visibility(
                      child: Container(),
                      visible: false,
                    )),
          body: Obx(
            () => _communityController.isInternetConnected.value == true
                ? _communityController.isLogin == true
                    ? Container(
                        width: size.width,
                        height: size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                colors: [
                              Color.fromRGBO(64, 18, 139, 1),
                              Color.fromRGBO(147, 54, 180, 1)
                            ])),
                        child: Column(
                          children: [
                            _appbar(size),
                            CommunityBody(
                              size,
                            )
                          ],
                        ),
                      )
                    : Center(child: LoginCenterWidget(size))
                : Center(

                    ///USER ISNT SIGNED
                    child: LoginCenterWidget(size)),
          )),
    );
  }
}

//THIS IS THE STRUCTURE OF LIST VIEW AND ITS FUTURE
// WE HAVE RETRIVED THE POSTS API
//THE API RETRIVE POST INFO INCLUDING THE USER INFO
//
Widget CommunityBody(Size size) {
  CommunityController _communityController = Get.find();
  return Expanded(
      child: FutureBuilder(
    future: _communityController.retrivePosts(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ListView.builder(
          shrinkWrap: true,
          cacheExtent: 1000,
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data['data'].length,
          itemBuilder: ((BuildContext context, int index) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("No data"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("An error occured"),
              );
            }

            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return SocialMediaPostTile(
                index: index,
                size: size,
                postData: PostData.fromJson(snapshot.data['data'][index]),

                // userData: UserData.fromJson(snapshot.data['data'][index]),
              ).paddingAll(10);
            }
            return Center(child: CircularProgressIndicator.adaptive());
          }));
    },
  ));
}

// Rest of the code...

Widget _appbar(Size size) {
  return Container(
    height: size.height * 0.06,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${userDataPreference.getString("field")} community",
          style: const TextStyle(
              color: white, fontWeight: FontWeight.bold, fontSize: 18),
          // style: ,
        ).paddingOnly(left: 20, top: 10),
        Expanded(child: Container()),
        const Icon(
          Icons.info_outline,
          color: white,
        ).paddingAll(10)
      ],
    ),
  );
}
