import 'dart:convert';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../db/db_helper.dart';
import '../../../model/tag_model.dart';

class TagBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagController(), fenix: true);
  }
}

class TagController extends BaseController {
  // var jsonResult;
  List<TagModel>? tagList;

  loadJson() async {
    String data = await rootBundle.loadString('assets/json/check.json');
    // jsonResult = json.decode(data);
    update();
    // print(jsonResult);
  }

  Future<void> getAllTags(String userId) async {
    var allTags = await DbHelp().getAllTagsByUser(userId);
    tagList?.clear();
    tagList = allTags;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    var userid = FirebaseAuth.instance.currentUser?.uid;
    getAllTags(userid!);
    // loadJson();
    update();
  }
}
