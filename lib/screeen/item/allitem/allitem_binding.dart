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
  bool isFavorite = true;
  List<AddItemModel>? itemlist;

  Future<void> getData() async {
    print("Favorite >>>><<<<< $userid");
    var allData = await DbHelp().getAllFavoriteList(userid!);
    itemlist?.clear();
    itemlist = allData;
    update();
  }

  favorritedatafalse(String? id) async {
    showLoadingDialog();
    if (isFavorite == false) {
      await DbHelp().updateFavorite(
          AddItemModel(
            favorite: isFavorite,
          ),
          id);
      print('Value id true $isFavorite');
      update();
      getData();
      hideDialog();
    } else {
      print('favorite $isFavorite');
      hideDialog();
    }
  }

  @override
  void onInit() {
    itemlist?.clear();
    getData();
    update();
    super.onInit();
  }
}
