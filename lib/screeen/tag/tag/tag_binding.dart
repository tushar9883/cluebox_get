import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../db/db_helper.dart';
import '../../../model/tag_model.dart';

class TagBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagController(), fenix: true);
  }
}

class TagController extends BaseController {
  final search = TextEditingController();
  var userid = FirebaseAuth.instance.currentUser?.uid;
  List<TagModel>? tagList;
  List<TagModel>? tagdataList;
  bool isLoading = false;

  Future<void> getAllTags(String userId) async {
    isLoading = true;
    var allTags = await DbHelp().getAllTagsByUser(userId);
    tagList?.clear();
    tagList = allTags;
    tagdataList = allTags;
    isLoading = false;
    update();
  }

  searching() {
    final suggestion = tagList?.where((element) {
      final title = element.name?.toLowerCase();
      final inpute = search.text.toLowerCase();

      return title!.contains(inpute);
    }).toList();
    tagdataList = suggestion;
    update();
  }

  back() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controll = Get.find<HomeController>();
      controll.getAllTags(userid!);
      controll.getData(userid!);
      controll.getUserData(userid!);
    });
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    getAllTags(userid!);
    update();
  }
}
