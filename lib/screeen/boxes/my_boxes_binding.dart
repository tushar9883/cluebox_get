import 'dart:convert';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../db/db_helper.dart';

class MyBoxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyBoxController(), fenix: true);
  }
}

class MyBoxController extends BaseController {
  List<BoxModel>? myBoxList;
  bool isLoading = false;
  LocationModel? locationModel;
  final search = TextEditingController();

  Future<void> getBoxLocWise() async {
    isLoading = true;

    locationModel = LocationModel.fromDb(Get.arguments);
    print("<><><>>>>>TagID><><>><><><>${locationModel?.uid}");
    var allData = await DbHelp().getBoxLocationWise(locationModel?.uid ?? '');
    myBoxList?.clear();
    myBoxList = allData;
    isLoading = false;
    update();
  }

  searching() {
    final suggestion = myBoxList?.where((element) {
      final title = element.name?.toLowerCase();
      final inpute = search.text.toLowerCase();

      return title!.contains(inpute);
    }).toList();
    myBoxList = suggestion;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    var userid = FirebaseAuth.instance.currentUser?.uid;
    getBoxLocWise();
    update();
  }
}
