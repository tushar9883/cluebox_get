import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/model/tag_model.dart';

import '../../../db/db_helper.dart';
import '../../../model/additem_model.dart';

class TagItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagItemController(), fenix: true);
  }
}

class TagItemController extends BaseController {
  TagModel? tagModel;
  List<AddItemModel>? itemList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllItemsFromTag();
  }

  Future<void> getAllItemsFromTag() async {
    tagModel = TagModel.fromDb(Get.arguments);

    print("<><><>>>>>TagID><><>><><><>${tagModel?.uid}");
    var allItems = await DbHelp().getItemsFromTag(tagModel?.uid ?? '');
    itemList = allItems;
    print("<><><>>>>>><><>><><><>${itemList?.first.itemName}");
    update();
  }
}
