import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/color.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}

class LoginController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final storage = const FlutterSecureStorage();

  login() async {
    if (email.text.isEmpty) {
      toastbar("Email is required");
    } else if (password.text.isEmpty) {
      toastbar("Password is required");
    } else {
      try {
        showLoadingDialog();
        update();
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);
        await storage.write(key: "uid", value: userCredential.user?.uid);
        hideDialog();
        Get.toNamed(RouterName.home);
        email.clear();
        password.clear();
        update();
      } on FirebaseAuthException catch (e) {
        hideDialog();
        update();
        if (e.code == 'user-not-found') {
          toastbar('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          toastbar('Wrong password');
        } else if (e.code == 'network-request-failed') {
          toastbar('Check Internet Connection');
        } else {
          toastbar('Something went wrong');
        }
      }
    }
  }
}
