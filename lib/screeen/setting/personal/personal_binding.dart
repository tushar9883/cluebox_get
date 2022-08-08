import 'dart:convert';
import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../model/country.dart';
import '../../../res/color.dart';

class PersonalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalController(), fenix: true);
  }
}

class PersonalController extends BaseController {
  var userid = FirebaseAuth.instance.currentUser?.uid;
  int radioSelected = 0;
  String radioVal = "";
  List<UserModel>? UserList;
  final TextEditingController name = TextEditingController();

  TextEditingController dateinput = TextEditingController();
  Country? selectedCountry;
  List<Country>? jsonCountry;
  final storage = const FlutterSecureStorage();
  bool isLoading = false;

  loadJson() async {
    // showLoadingDialog();
    var data = await rootBundle.loadString('assets/json/country.json');
    List res = jsonDecode(data);
    print('111111111111111111${res}');
    if (res != null) {
      jsonCountry = res.map((e) => Country.fromJson(e)).toList();
      selectedCountry?.name = jsonCountry?.first.name;
    }
    update();
    // hideDialog();
    print(jsonCountry);
  }

  // Read value

  @override
  void onInit() {
    super.onInit();
    dateinput.text = "";
    dataget();
    loadJson();
    update();
  }

  savedata() async {
    showLoadingDialog();
    var valuegender;
    String? uidd = await storage.read(key: "uid");
    print("user id :- $uidd");

    print('Gender:- $radioSelected');
    print("selected country :- ${selectedCountry?.name}");
    if (radioSelected == 1) {
      valuegender = 'Male';
    } else if (radioSelected == 2) {
      valuegender = 'Female';
    } else {
      radioSelected = 0;
    }
    await DbHelp().updateUser(
        UserModel(
            name: name.text,
            country: selectedCountry?.name,
            gender: valuegender,
            birthdate: dateinput.text),
        uidd);
    toastbar("Personal Info updated successfully", isSuccess: true);
    hideDialog();
    Get.back();
  }

  dataget() async {
    isLoading = true;
    print("Personal >>>><<<<< $userid");
    var getUserData = await DbHelp().getUserDetails(userid ?? "");
    UserList?.clear();
    UserList = getUserData;
    name.text = UserList?.first.name ?? '';
    dateinput.text = UserList?.first.birthdate ?? '';
    selectedCountry?.name = UserList?.first.country;

    ///TODO Dropdown Value Save
    if (jsonCountry != null) {
      for (var countryData in jsonCountry!) {
        if (countryData.name == UserList?.first.country) {
          selectedCountry = countryData;
        }
      }
    }

    if (UserList?.first.gender == 'Male') {
      radioSelected = 1;
    } else if (UserList?.first.gender == 'Female') {
      radioSelected = 2;
    } else {
      radioSelected = 0;
    }
    // jsonCountry = "fds";
    print("name ${UserList?.last.name}");
    print("gender ${UserList?.last.gender}");
    print("country ${UserList?.last.country}");
    print("birthdate ${UserList?.last.birthdate}");
    isLoading = false;
    update();
  }
}
