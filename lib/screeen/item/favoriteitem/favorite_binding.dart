import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController(), fenix: true);
  }
}

class FavoriteController extends BaseController {
  final search = TextEditingController();
  List<AddItemModel>? favoriteist;
  // bool isFavorite = true;
  bool isLoading = false;

  var userid = FirebaseAuth.instance.currentUser?.uid;

  Future<void> getData() async {
    isLoading = true;
    print("Favorite >>>><<<<< $userid");
    var allData = await DbHelp().getAllFavoriteList(userid!);
    favoriteist?.clear();
    favoriteist = allData;
    isLoading = false;
    update();
  }

  searching() {
    final suggestion = favoriteist?.where((element) {
      final title = element.itemName?.toLowerCase();
      final inpute = search.text.toLowerCase();

      return title!.contains(inpute);
    }).toList();
    favoriteist = suggestion;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    getData();
  }
}
