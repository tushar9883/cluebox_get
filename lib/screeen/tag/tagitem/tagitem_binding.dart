import 'package:clue_get/base/base_view_view_model.dart';

class TagItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagItemController(), fenix: true);
  }
}

class TagItemController extends BaseController {}
