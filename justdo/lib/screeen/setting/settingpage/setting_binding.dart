import 'package:clue_get/base/base_view_view_model.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController(), fenix: true);
  }
}

class SettingController extends BaseController {}
