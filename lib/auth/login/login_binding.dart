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
}
