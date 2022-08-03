import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController(), fenix: true);
  }
}

class FavoriteController extends BaseController {
  List<AddItemModel>? favoriteist;
  // bool isFavorite = true;
  bool isLoading = false;

  var userid = FirebaseAuth.instance.currentUser?.uid;

  Future<void> getData() async {
    isLoading = true;
    print("Favorite >>>><<<<< $userid");
    var allData = await DbHelp().getAllFavoriteList(userid!);
    favoriteist?.clear();
    favoriteist = allData;
    isLoading = false;
    update();
  }

  // favorritedata(String? id) async {
  //   showLoadingDialog();
  //   if (isFavorite == false) {
  //     await DbHelp().updateFavorite(
  //         AddItemModel(
  //           favorite: isFavorite,
  //         ),
  //         id);
  //     print('Value id true $isFavorite');
  //     update();
  //     getData();
  //     hideDialog();
  //   } else {
  //     print('Value id true $isFavorite');
  //     hideDialog();
  //   }
  // }

  @override
  void onInit() async {
    super.onInit();
    getData();
  }
}
