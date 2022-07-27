import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddItemController(), fenix: true);
  }
}

class AddItemController extends BaseController {
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var itemsss = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final counter = TextEditingController();
  final Nameitem = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();

  String dropdownvalue = 'Item 1';
  String dropdownvaluess = 'Item 1';

  @override
  void onInit() {
    counter.text = "0";
    update();
    super.onInit();
  }

  additem() async {
    showLoadingDialog();
    final _utcTime = DateTime.now().toUtc();
    final Localtime = _utcTime.toLocal();
    print("Create Time:- $Localtime");
    print(
        ">>>>>>>>> ${tagController.getTags} ...... \n ${counter.text} <<<<<< \n ${Nameitem.text} ^^^^^^^^^ \n ${dropdownvalue} <><><><> \n ${dropdownvaluess}");
    await DbHelp().addlocation(LocationModel(
        userid: FirebaseAuth.instance.currentUser?.uid,
        itemName: Nameitem.text,
        tag: tagController.getTags.toString(),
        box: dropdownvalue,
        location: dropdownvaluess,
        quantity: counter.text,
        date: Localtime.toString(),
        image:
            "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"));
    hideDialog();
    Get.back();
    Nameitem.clear();
    update();
  }
}
