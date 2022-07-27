import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/color.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotController(), fenix: true);
  }
}

class ForgotController extends BaseController {
  TextEditingController email = TextEditingController();

  @override
  void onInit() {
    setScreenState = screenStateOk;
    update();
    super.onInit();
  }

  forgot() async {
    showLoadingDialog();
    if (email.text.isEmpty) {
      toastbar("User name is required");
    } else {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email.text.trim());
        toastbar('Password Reset Email Send');
        Get.back();
        Get.offNamed(RouterName.login);
        update();
      } on FirebaseAuthException catch (e) {
        hideDialog();
        update();
        toastbar('Something went wrong');
      }
    }
  }
}
