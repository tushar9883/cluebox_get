import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
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
  AddItemModel? item;
  BoxModel? myBox;

  Future<void> getData() async {
    print("Favorite >>>><<<<< $userid");
    var allData = await DbHelp().getAllItemList(userid!, boxId: myBox?.uid);
    itemlist?.clear();
    itemlist = allData;
    update();
  }

  searching() {
    final suggestion = itemlist?.where((element) {
      final title = element.itemName?.toLowerCase();
      final inpute = search.text.toLowerCase();

      return title!.contains(inpute);
    }).toList();
    itemlist = suggestion;
    update();
  }

  deleteitem() async {
    List<UserModel>? userData = await DbHelp().getuserData(userid!);
    TagModel? tagData = await DbHelp().getTagData(userid!);

    if (userData.isNotEmpty) {
      //To update item count of this user
      userData.first.itemCount = (userData.first.itemCount ?? 0) - 1;
      await DbHelp().udpateUserData(userData.first, userData.first.uid);
      print("User itemCount updated___________");
    }
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

    getData();
    update();
    super.onInit();
  }
}
