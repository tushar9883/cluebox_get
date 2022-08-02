import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:clue_get/res/color.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SingupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingupController(), fenix: true);
  }
}

class SingupController extends BaseController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final storage = const FlutterSecureStorage();

  signup() async {
    if (email.text.isEmpty) {
      toastbar("User email is required");
    } else if (name.text.isEmpty) {
      toastbar('User name is required');
    } else if (name.text.length < 2) {
      toastbar('Enter valid name ');
    } else if (pass.text.isEmpty) {
      toastbar("Password is required");
    } else if (pass.text.length < 8) {
      toastbar("This password is too short."
          " It must contain at least 8 characters.");
    } else {
      try {
        showLoadingDialog();
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: pass.text.trim());
        await storage.write(key: "userid", value: userCredential.user?.uid);
        var data = await DbHelp().adduser(UserModel(
          name: name.text.trim(),
          email: email.text.trim(),
          password: pass.text.trim(),
          userid: FirebaseAuth.instance.currentUser?.uid,
        ));
        print("uid :- ${data.id}");
        await storage.write(key: "uid", value: data.id);
        print(
            "Data Name : ${name.text} \n Email: ${email.text}\n User Id : ${FirebaseAuth.instance.currentUser?.uid} \n Password : ${pass.text}");
        hideDialog();
        Get.toNamed(RouterName.home);
        email.clear();
        pass.clear();
        name.clear();
        update();
      } on FirebaseAuthException catch (e) {
        hideDialog();
        update();
        if (e.code == 'weak-password') {
          toastbar('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          toastbar('The account already exists');
        } else if (e.code == 'network-request-failed') {
          toastbar('Check Internet Connection');
        } else if (e.code == 'invalid-email') {
          toastbar('Invalid Email');
        } else {
          print(e.code);
          toastbar('Something went wrong');
        }
      }
    }
  }
}
