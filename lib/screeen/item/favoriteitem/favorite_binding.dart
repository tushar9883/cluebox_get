import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/favorite_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController(), fenix: true);
  }
}

class FavoriteController extends BaseController {
  List<FavoriteModel>? favoriteist;

  var userid = FirebaseAuth.instance.currentUser?.uid;

  Future<void> getData() async {
    print("Favorite ID >>>><<<<< $userid");
    var allData = await DbHelp().getFavoriteList(userid ?? '');
    favoriteist?.clear();
    favoriteist = allData;
    print(">?:>:>D<CPF<DP<CVD ${allData.length}");
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    getData();
  }
}
