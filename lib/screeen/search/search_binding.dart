import 'package:clue_get/base/base_view_view_model.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(), fenix: true);
  }
}

class SearchController extends BaseController {
  List<String> items = <String>[
    "Electronics",
    "Stationaries",
    "Drinks",
    "Medicines",
  ];
  final List<String> content = [
    'iPhone Cover',
    'Plastic Whistle',
    'Football Air Pump',
    'Torch',
    'Lighter',
    'Locker Key',
    'Red Flower Vase',
    'Dice',
    'Smoke Pump ',
    'Spider Man T-Shirt',
    'Silver Specs'
  ];
  late List<String> data;
}
