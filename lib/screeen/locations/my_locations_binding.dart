import 'dart:convert';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../db/db_helper.dart';

class MyLocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyLocationController(), fenix: true);
  }
}

class MyLocationController extends BaseController {
  var userid = FirebaseAuth.instance.currentUser?.uid;
  final search = TextEditingController();
  // var jsonResult;
  List<LocationModel>? myLocationList;
  List<LocationModel>? mydataLocationList;
  bool isLoading = false;

  Future<void> getAllLocations(String userId) async {
    isLoading = true;
    var allLocations = await DbHelp().getAllLocation(userId);
    myLocationList?.clear();
    myLocationList = allLocations;
    mydataLocationList = allLocations;
    isLoading = false;
    update();
  }

  searching() {
    final suggestion = myLocationList?.where((element) {
      final title = element.name?.toLowerCase();
      final inpute = search.text.toLowerCase();

      return title!.contains(inpute);
    }).toList();
    mydataLocationList = suggestion;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllLocations(userid!);
    // loadJson();
    update();
  }
}
