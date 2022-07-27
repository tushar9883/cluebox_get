import 'package:clue_get/base/base_view_view_model.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}

class HomeController extends BaseController {
  List<String> items = <String>[
    "Electronics",
    "Stationaries",
    "Drinks",
    "Medicines",
  ];

  late List<String> data;
}
