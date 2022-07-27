import 'package:clue_get/base/base_view_view_model.dart';

class ChangePassBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePassController(), fenix: true);
  }
}

class ChangePassController extends BaseController {}
