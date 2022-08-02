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
  bool isFavoritetrue = true;
  List<AddItemModel>? itemlist;

  Future<void> getData() async {
    print("Favorite >>>><<<<< $userid");
    var allData = await DbHelp().getAllFavoriteList(userid!);
    itemlist?.clear();
    itemlist = allData;
    update();
  }

  favorritedatatrue(String? id) async {
    showLoadingDialog();
    if (isFavoritetrue == false) {
      await DbHelp().updateFavorite(
          AddItemModel(
            favorite: isFavoritetrue,
          ),
          id);
      print('Value id true $isFavoritetrue');
      update();
      getData();
      hideDialog();
    } else {
      print('favorite $isFavoritetrue');
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
