import '../../base/base_controller.dart';

class ViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewController(), fenix: true);
  }
}

class ViewController extends BaseController {
  bool isLoading = false;
}
