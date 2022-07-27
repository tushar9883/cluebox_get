import 'dart:convert';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:flutter/services.dart';

class TagBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagController(), fenix: true);
  }
}

class TagController extends BaseController {
  var jsonResult;

  loadJson() async {
    String data = await rootBundle.loadString('assets/json/check.json');
    jsonResult = json.decode(data);
    update();
    print(jsonResult);
  }

  @override
  void onInit() {
    loadJson();
    update();
    super.onInit();
  }
}
