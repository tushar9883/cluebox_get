import 'package:clue_get/base/base_view_view_model.dart';
import 'package:flutter/material.dart';

class PersonalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalController(), fenix: true);
  }
}

class PersonalController extends BaseController {
  int radioSelected = 1;
  String radioVal = "";
  String dropdownvalue = 'Item 1';
  TextEditingController dateinput = TextEditingController();
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  void onInit() {
    dateinput.text = "";
    update();
    super.onInit();
  }
}
