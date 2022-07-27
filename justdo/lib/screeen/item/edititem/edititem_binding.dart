import 'package:clue_get/base/base_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EditItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditItemController(), fenix: true);
  }
}

class EditItemController extends BaseController {
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var itemsss = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final counter = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();

  String dropdownvalue = 'Item 1';
  String dropdownvaluess = 'Item 1';

  @override
  void onInit() {
    counter.text = "0";
    update();
    super.onInit();
  }
}
