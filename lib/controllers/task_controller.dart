// import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import '../constants/hot_links.dart';
import '../db/db_helper.dart';
import '../db/sql.dart';
import '../models/task.dart';
import '../ui/widgets/alert_dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController { 

  //THIS FUNCTIONS IS CALLED FROM AN ALERT DIALOG 
  //THIS ALERT DIALOG SHOW ONCE A NEW VERSIOM IS RELEASED THEN A USER CLICKS UPDATE AND NAVIGATES TO APP STOREf
  Future launchAppUrl() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.zamelstudios.newme';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  //THIS FUNCTION IS EXECUTED FIRSTLY TO CHECK IF AN UPDATE IS AVAIALBLE THEN SHOWS AN ALERT WHICH 
  //NAVIGATES USER TO APPSTORE
  void isThereNewUpdate(context, img_link, main_text, title) async {
    final appVersion = await PackageInfo.fromPlatform();
    String version = appVersion.version;
    var response =
        await postRequest(checkAppVersionLink, {"app_version": '22'});

    if (response['app_version'].toString() != version) {
      Dialogs().new_update_dialog(context, img_link, main_text, title);
    } else {
      print("nooooooo");
    }
  }

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  final RxList<Task> taskList = List<Task>.empty().obs;

  // add data to table
  //second brackets means they are named optional parameters
  Future<void> addTask({required Task task}) async {
    await DBHelper.insert(task);
  }

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  // delete data from table
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  // update data int table
  void markTaskCompleted(int? id) async {
    await DBHelper.update(id);

    getTasks();
    // completedTaskSound();
    // _player.stop();
    //after a task is completed a ding sound is played
  }
}
