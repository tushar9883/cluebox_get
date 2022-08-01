import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
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
  List<AddItemModel>? itemlist;
  var userid = FirebaseAuth.instance.currentUser?.uid;
  String? isLoggedIn;
  List<String> items = <String>[
    "Electronics",
    "Stationaries",
    "Drinks",
    "Medicines",
  ];
  Future<void> getData() async {
    print("User  >>>><<<<< $userid");
    var allData = await DbHelp().getRecentItemList(userid!);
    itemlist?.clear();
    itemlist = allData;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    getData();
    var check = await storagess.read(key: "uid");
    isLoggedIn = check;
    print(">>>>> User ID  ${check.toString()}  >>>>> ");
    update();
  }

  late List<String> data;
}
