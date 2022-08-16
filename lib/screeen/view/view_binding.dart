import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
  var outputDate;
  AddItemModel? itemModel;

  Future<void> getAllTags(String userId) async {
    var allTags = await DbHelp().getAllTagsByUser(userId);
    tagList?.clear();
    tagList = allTags;
    // print("tags>>>><<<<< ${tagList?.first.name}");
    update();
  }

  getnewdata() async {
    if (Get.arguments != null) {
      itemModel = AddItemModel.fromDB(Get.arguments);
      print("444444444444444 ${itemModel?.tag}");
      print("444444445555554444444 ${itemModel?.uid}");
      imgUrl = itemModel?.image;
      var dates = itemModel?.date;
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(dates!);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd MMM yyyy');
      outputDate = outputFormat.format(inputDate);
      print(outputDate);

      update();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    var userid = FirebaseAuth.instance.currentUser?.uid;
    getAllTags(userid!);
    getnewdata();
    super.onInit();
    update();
  }
}
