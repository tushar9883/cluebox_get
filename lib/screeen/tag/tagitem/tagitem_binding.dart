import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../db/db_helper.dart';
import '../../../model/additem_model.dart';
import '../../../router/router_name.dart';
import '../../home/home_binding.dart';
import '../tag/tag_binding.dart';

class TagItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagItemController(), fenix: true);
  }
}

class TagItemController extends BaseController {
  TagModel? tagModel;
  List<AddItemModel>? itemList;
  final search = TextEditingController();
  final tagName = TextEditingController();
  var userid = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllItemsFromTag();
    tagName.text = tagModel!.name!;
  }

  Future<void> getAllItemsFromTag() async {
    isLoading = true;
    tagModel = TagModel.fromDb(Get.arguments);
    print("<><><>>>>>TagID><><>><><><>${tagModel?.uid}");
    var allItems = await DbHelp().getItemsFromTag(tagModel?.uid ?? '');
    itemList = allItems;
    isLoading = false;
    update();
  }

  searching() {
    final suggestion = itemList?.where((element) {
      final title = element.itemName?.toLowerCase();
      final inpute = search.text.toLowerCase();
      return title!.contains(inpute);
    }).toList();
    itemList = suggestion;
    update();
  }

  deleteitem() async {
    List<UserModel>? userData = await DbHelp().getuserData(userid!);

    if (userData.isNotEmpty) {
      //To update item count of this user
      userData.first.itemCount = (userData.first.itemCount ?? 0) - 1;
      await DbHelp().udpateUserData(userData.first, userData.first.uid);
      print("User itemCount updated___________");

      TagModel? tagData = await DbHelp().getTagData('${tagModel?.uid}');
      var tagIds = [];
      if (tagData != null) {
        tagIds.add(tagData.uid);
        tagData.tagItemCount = (tagData.tagItemCount ?? 0) - 1;
        await DbHelp().addtag(tagData);
        print("Removed____tagItemCount_________");
      }

      // Get.until((route) => Get.currentRoute == RouterName.tag);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        var controlH = Get.find<HomeController>();
        controlH.getData(userid!);
        controlH.getAllTags(userid!);
        controlH.getUserData(userid!);
        var controll = Get.find<TagController>();
        controll.getAllTags(userid!);
      });
    }
  }
}
