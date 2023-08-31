import '../../constants/hot_links.dart';
import '../../main.dart';

import '../../db/sql.dart';

class GetCurrentUserData {
  String? getUserId = userDataPreference.getString("id");
  // Crud crud = new Crud();
  Future getCurrentUserData() async {
    try {
      var response = postRequest(usersDataLink, {"user_id_n": getUserId});

      return response;
    } catch (e) {
      print(e);
    }
  }
}
