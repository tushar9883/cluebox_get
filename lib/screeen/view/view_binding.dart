import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../base/base_controller.dart';

class ViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewController(), fenix: true);
  }
}

class ViewController extends BaseController {
  bool isLoading = false;
  bool isFavorite = false;
  List<TagModel>? tagList;
  var imgUrl;

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
    getAllTags(userid!);
    super.onInit();
    update();
  }
}
