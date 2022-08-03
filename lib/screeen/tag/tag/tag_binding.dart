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
  List<TagModel>? tagList;
  bool isLoading = false;

  Future<void> getAllTags(String userId) async {
    isLoading = true;
    var allTags = await DbHelp().getAllTagsByUser(userId);
    tagList?.clear();
    tagList = allTags;
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    var userid = FirebaseAuth.instance.currentUser?.uid;
    getAllTags(userid!);
    update();
  }
}
