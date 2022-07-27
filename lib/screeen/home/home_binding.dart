import 'package:clue_get/base/base_view_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}

class HomeController extends BaseController {
  FlutterSecureStorage storagess = const FlutterSecureStorage();
  String? isLoggedIn;

  List<String> items = <String>[
    "Electronics",
    "Stationaries",
    "Drinks",
    "Medicines",
  ];
  @override
  void onInit() async {
    var check = await storagess.read(key: "uid");
    isLoggedIn = check;
    print(">>>>> User ID  ${check.toString()}  >>>>> ");
    update();
    super.onInit();
  }

  late List<String> data;
}
