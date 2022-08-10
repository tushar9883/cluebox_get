import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
import 'package:clue_get/screeen/tag/tag/tag_binding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllItemController(), fenix: true);
  }
}

class AllItemController extends BaseController {
  var userid = FirebaseAuth.instance.currentUser?.uid;
  final search = TextEditingController();
  bool isFavoritetrue = true;
  List<AddItemModel>? itemlist;
  List<AddItemModel>? storage;
  List<TagModel>? tages;
  // TagModel? tagModel;
  List<TagModel>? tagList;
  AddItemModel? item;
  BoxModel? myBox;
  bool isLoading = false;

  Future<void> getData() async {
    isLoading = true;
    print("Favorite >>>><<<<< $userid");
    var allData = await DbHelp().getAllItemList(userid!, boxId: myBox?.uid);
    itemlist?.clear();
    itemlist = allData;
    storage = allData;
    isLoading = false;
    update();
  }

  searching() {
    if (search.text.isNotEmpty) {
      final suggestion = itemlist?.where((element) {
        final title = element.itemName?.toLowerCase();
        final inpute = search.text.toLowerCase();

        return title!.contains(inpute);
      }).toList();
      storage = suggestion;
      update();
      print('1314484646464561${suggestion?.length}');
    }
  }

  tag() async {
    tages = await DbHelp().getAllTagsByUser(userid!);
  }

  deleteitem() async {
    isLoading = true;
    List<UserModel>? userData = await DbHelp().getuserData(userid!);

    if (userData.isNotEmpty) {
      //To update item count of this user
      userData.first.itemCount = (userData.first.itemCount ?? 0) - 1;
      await DbHelp().udpateUserData(userData.first, userData.first.uid);
      print("User itemCount updated___________");
      print('tag id  ----- ${tages?.first.uid}');

      TagModel? tagData = await DbHelp().getTagData('${tages?.first.uid}');
      var tagIds = [];
      if (tagData != null) {
        tagIds.add(tagData.uid);
        tagData.tagItemCount = (tagData.tagItemCount ?? 0) - 1;
        await DbHelp().addtag(tagData);
        print("User Tag updated___________");
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        var controlH = Get.find<HomeController>();
        controlH.getData(userid!);
        controlH.getAllTags(userid!);
        controlH.getUserData(userid!);
        // var controll = Get.find<TagController>();
        // controll.getAllTags(userid!);
      });
    }

    isLoading = false;
  }

  back() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controll = Get.find<HomeController>();
      controll.getUserData(userid!);
      controll.getData(userid!);
    });
    Get.back();
  }

  @override
  void onInit() {
    itemlist?.clear();

    if (Get.arguments != null) {
      myBox = BoxModel.fromDB(Get.arguments);
    }
    tag();
    getData();
    print('tag id  ----- ${tages?.first.uid}');
    update();
    super.onInit();
  }
}
