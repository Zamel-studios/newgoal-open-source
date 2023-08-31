import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';

void customSnackBar(text) {
  Get.snackbar(text, "",
      padding: EdgeInsets.all(10),
      colorText: red_c,
      snackPosition: SnackPosition.TOP);
}
