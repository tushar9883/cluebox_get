import 'package:clue_get/base/base_view_view_model.dart';

class ChangeMailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeMailController(), fenix: true);
  }
}

class ChangeMailController extends BaseController {}
