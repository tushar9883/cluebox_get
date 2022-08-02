import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:intl/intl.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}

class HomeController extends BaseController {
  FlutterSecureStorage storagess = const FlutterSecureStorage();
  List<AddItemModel>? itemList;
  List<TagModel>? tagList;
  String? isLoggedIn;
  // List<String> items = <String>[
  //   "Electronics",
  //   "Stationaries",
  //   "Drinks",
  //   "Medicines",
  // ];
  Future<void> getData(String userId) async {
    print("User ID >>>><<<<< $userId");
    var allData = await DbHelp().getAllItemList(userId);
    itemList?.clear();
    itemList = allData;
    update();
  }

  Future<void> getAllTags(String userId) async {
    var allTags = await DbHelp().getAllTagsByUser(userId);
    tagList?.clear();
    tagList = allTags;
    // print("tags>>>><<<<< ${tagList?.first.name}");
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    var userid = FirebaseAuth.instance.currentUser?.uid;
    getData(userid!);
    getAllTags(userid);
    var check = await storagess.read(key: "uid");
    isLoggedIn = check;
    print(">>>>> User ID  ${check.toString()}  >>>>> ");
    update();
  }

  late List<String> data;
}
