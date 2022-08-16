import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:intl/intl.dart';
import '../../base/base_controller.dart';

class ViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewController(), fenix: true);
  }
}

class ViewController extends BaseController {
  bool isLoading = false;
  bool isFavorite = false;
  var imgUrl;
  var outputDate;

  List<TagModel?> tagdata = [];
  AddItemModel? itemModel;

  getnewdata() async {
    if (Get.arguments != null) {
      isLoading = true;
      //Loader start
      itemModel = AddItemModel.fromDB(Get.arguments);

      imgUrl = itemModel?.image;
      var tagids = itemModel?.tag;
      var dates = itemModel?.date;
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(dates!);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd MMM yyyy');
      outputDate = outputFormat.format(inputDate);
      if (tagids != null) {
        var tagList = tagids.map((e) => e.toString()).toList();
        var tag = await DbHelp().getTagListData(tagList);
        tagdata = tag!;
        isLoading = false;
        update();
      }
      isLoading = false;
      //Loader end
      update();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getnewdata();
    super.onInit();
    update();
  }
}
