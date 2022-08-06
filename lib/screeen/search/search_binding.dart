import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(), fenix: true);
  }
}

class SearchController extends BaseController {
  final search = TextEditingController();
  var userid = FirebaseAuth.instance.currentUser?.uid;
  List<AddItemModel>? searchModel;

  getSeachResult() async {
    var allresult = await DbHelp().getsearch(search.text, userid!);
    searchModel?.clear();
    searchModel = allresult;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    update();
  }
}
