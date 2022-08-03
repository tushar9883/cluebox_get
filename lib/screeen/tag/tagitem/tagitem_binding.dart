import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../db/db_helper.dart';
import '../../../model/additem_model.dart';

class TagItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagItemController(), fenix: true);
  }
}

class TagItemController extends BaseController {
  TagModel? tagModel;
  List<AddItemModel>? itemList;
  var userid = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllItemsFromTag();
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

  deleteitem() async {
    List<UserModel>? userData = await DbHelp().getuserData(userid!);

    if (userData.isNotEmpty) {
      //To update item count of this user
      userData.first.itemCount = (userData.first.itemCount ?? 0) - 1;
      await DbHelp().udpateUserData(userData.first, userData.first.uid);
      print("User itemCount updated___________");
    }
  }
}
