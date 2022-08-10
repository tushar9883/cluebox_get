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
  bool isLoading = false;
  List<String> values = [];
  bool isFirst = true;

  getSeachResult() async {
    isLoading = true;
    var allresult = await DbHelp().getsearch(search.text, userid!);
    searchModel?.clear();
    searchModel = allresult;
    print("sdicbf${allresult}");
    storvalue();
    isLoading = false;
    update();
  }

  storvalue() async {
    if (search.text.isNotEmpty) {
      values.add(search.text);
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList("data", values);
      prefs.commit();
      print("token is: ${prefs.getStringList("data")}");
    }
  }

  Future<List<String>> getValues() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? value = sharedPreferences.getStringList("data");
    values = value!;
    try {
      values = values.reversed.toList();
      values.removeRange(10, value.length);
    } catch (e) {
      print(e);
    }

    print("your data: $value");
    update();
    return value;
  }

  @override
  void onInit() {
    super.onInit();
    getValues();
    update();
  }
}
