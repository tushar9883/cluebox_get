import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllItemController(), fenix: true);
  }
}

class AllItemController extends BaseController {
  var userid = FirebaseAuth.instance.currentUser?.uid;

  List<AddItemModel>? itemlist;

  Future<void> getData() async {
    print("User ID >>>><<<<< $userid");
    var allData = await DbHelp().getAllItemList(userid!);
    itemlist?.clear();
    itemlist = allData;
    update();
  }

  @override
  void onInit() {
    itemlist?.clear();
    getData();
    update();
    super.onInit();
  }
}
