import 'package:clue_get/base/base_view_view_model.dart';
import 'package:flutter/material.dart';

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
}
