import 'dart:convert';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../db/db_helper.dart';

class MyLocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyLocationController(), fenix: true);
  }
}

class MyLocationController extends BaseController {
  // var jsonResult;
  List<LocationModel>? myLocationList;
  bool isLoading = false;

  loadJson() async {
    String data = await rootBundle.loadString('assets/json/check.json');
    // jsonResult = json.decode(data);
    update();
    // print(jsonResult);
  }

  Future<void> getAllLocations(String userId) async {
    isLoading = true;
    var allLocations = await DbHelp().getAllLocation(userId);
    myLocationList?.clear();
    myLocationList = allLocations;
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    var userid = FirebaseAuth.instance.currentUser?.uid;
    getAllLocations(userid!);
    // loadJson();
    update();
  }
}
