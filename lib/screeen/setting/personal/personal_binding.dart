import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/userinfo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalController(), fenix: true);
  }
}

class PersonalController extends BaseController {
  var userid = FirebaseAuth.instance.currentUser?.uid;
  int radioSelected = 0;
  List<UserinfoModel>? allpersonalData;
  String radioVal = "";
  final TextEditingController name = TextEditingController();
  String dropdownvalue = 'Item 1';
  TextEditingController dateinput = TextEditingController();
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void onInit() {
    super.onInit();
    dateinput.text = "";
    dataget();

    update();
  }

  savedata() async {
    // showLoadingDialog();
    final _utcTime = DateTime.now().toUtc();
    final Localtime = _utcTime.toLocal();
    print('Gender:- $radioVal');
    await DbHelp().personalinfo(
      UserinfoModel(
        userid: userid,
        name: name.text,
        gender: radioVal,
        country: dropdownvalue,
        dateBirth: dateinput.text,
        date: Localtime.toString(),
      ),
    );
    hideDialog();
    // name.clear();
    // dateinput.clear();
  }

  dataget() async {
    print("Personal >>>><<<<< $userid");
    var dataget = await DbHelp().getuserInfoList(userid ?? "");
    // allpersonalData?.clear();
    allpersonalData = dataget;
    print('><><><><><><><><> ${allpersonalData?.length}');
    name.text = allpersonalData?.first.name ?? '';
    dateinput.text = allpersonalData?.first.dateBirth ?? '';
    if (allpersonalData?.first.gender == 'Male') {
      radioSelected = 1;
    } else {
      radioSelected = 2;
    }
    dropdownvalue = allpersonalData?.first.country ?? '';
    print("name ${allpersonalData?.last.name}");
    print("gender ${allpersonalData?.last.gender}");
    print("country ${allpersonalData?.last.country}");
    print("birthdate ${allpersonalData?.last.dateBirth}");
    update();
  }
}
