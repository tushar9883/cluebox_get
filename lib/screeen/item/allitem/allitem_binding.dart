import 'package:clue_get/base/base_view_view_model.dart';

class AllItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllItemController(), fenix: true);
  }
}

class AllItemController extends BaseController {
  late List<String> data;
}
