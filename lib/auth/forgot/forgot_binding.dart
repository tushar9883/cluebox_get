import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/color.dart';
import 'package:flutter/material.dart';

class ForgotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotController(), fenix: true);
  }
}

class ForgotController extends BaseController {
  TextEditingController email = TextEditingController();
  emailLink() async {
    if (email.text.isEmpty) {
      toastbar("Email is required");
    }
  }
}
