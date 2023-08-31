import 'package:get/get_utils/get_utils.dart';
import 'translations.dart';

validateInput(String val, int min, int max, String type) {
  switch (type) {
    case "email":
      if (val == "") return short_email_en; //emoty field
      if (val.length < min) return "10".tr;
      //  if (val.contains(" ")) return "37".tr;
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(val)) {
        return "37".tr;
      }
      if (val.contains(" ")) return "37".tr;

      break;

    case "password":
      if (val == "") return "11".tr; //emoty field
      if (val.length > max) return "12".tr;
      if (val.length < min) return "11".tr;
      if (val.contains(" ")) return "39".tr;

      break;

    case "name":
      if (val == "") return "13".tr; //emoty field
      if (val.length > max) return "14".tr;
      if (val.length < min) return "13".tr;
      // if (!RegExp(r'^[a-z A-Z]+$').hasMatch(val)) return "38".tr;
      // if (val.contains(" ")) return "38".tr;

      break;
    default:
  }
  return;
}
