import 'package:clue_get/base/base_view_view_model.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController(), fenix: true);
  }
}

class FavoriteController extends BaseController {}
