import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(), fenix: true);
  }
}

class SearchController extends BaseController {
  final storage = const FlutterSecureStorage();
  final search = TextEditingController();
  var userid = FirebaseAuth.instance.currentUser?.uid;
  List<AddItemModel>? searchModel;
  bool result = false;
  List<String> values = [];

  getSeachResult() async {
    var allresult = await DbHelp().getsearch(search.text, userid!);
    searchModel?.clear();
    searchModel = allresult;
    print("sdicbf${allresult}");
    storvalue();
    getToken();
    update();
  }

  storvalue() async {
    if (search.text.isNotEmpty) {
      values.add(search.text);
      setToken();
    }
  }

  // storageGet() async {
  //   var check = await storage.read(key: "search");
  //   print("datatatatatatat ${check!.length}");
  //   print("valuessss data  ${check}");
  // }

  void setToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("data", values.toString());
    print("token is: ${prefs.getString("data")}");
  }

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.reload();
    String? value = sharedPreferences.getString("data");
    print("your data: $value");
    return value;
  }

  @override
  void onInit() {
    super.onInit();
    // storageGet();
    setToken();
    update();
  }
}
