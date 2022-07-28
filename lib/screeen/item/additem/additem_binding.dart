import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/res/color.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
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
  var boxss = [
    'Add New Box',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var locationss = [
    'Add Location',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final counter = TextEditingController();
  final Nameitem = TextEditingController();
  final LocationName = TextEditingController();
  final BoxName = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();

  // String dropdownvalue = 'Item 1';
  String? boxvalue;
  String? locationvaluess;
  bool showBox = false;
  bool showLocation = false;

  var userid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void onInit() {
    counter.text = "0";
    update();
    super.onInit();
  }

  additem() async {
    final _utcTime = DateTime.now().toUtc();
    final Localtime = _utcTime.toLocal();
    final taggs = tagController.getTags;
    var stringList = taggs?.join("");

    showLoadingDialog();
    if (showLocation == true) {
      if (showBox == true) {
        if (LocationName.text.isEmpty) {
          hideDialog();
          toastbar("Location name is required");
        } else if (BoxName.text.isEmpty) {
          hideDialog();
          toastbar("Box name is required");
        } else {
          if (locationvaluess == 'Add Location' || boxvalue == 'Add New Box') {
            await DbHelp().addlocation(AddItemModel(
                userid: userid,
                itemName: Nameitem.text,
                tag: stringList,
                box: BoxName.text,
                location: LocationName.text,
                quantity: counter.text,
                date: Localtime.toString(),
                image:
                    "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"));
            await DbHelp().adlocation(LocationModel(
                name: LocationName.text,
                userid: userid,
                date: Localtime.toString()));
            await DbHelp().adbox(BoxModel(
                userid: userid,
                name: BoxName.text,
                date: Localtime.toString(),
                locationName: LocationName.text));
            await DbHelp().adtag(TagModel(
                userid: userid, name: stringList, date: Localtime.toString()));
            print(
                "?>?>?>?>>>>> ${LocationName.text} <?<?<??<?<?<?  ${BoxName.text}");
          }
          print(
              'Boxname : ${BoxName.text} >>> Location Name: ${LocationName.text}');
          hideDialog();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            var controll = Get.find<HomeController>();
            controll.getData();
          });
          Get.back();
          Nameitem.clear();
          BoxName.clear();
          LocationName.clear();
          update();
        }
      } else if (showBox == false) {
        if (LocationName.text.isEmpty) {
          hideDialog();
          toastbar("Location name is required");
        } else {
          await DbHelp().addlocation(AddItemModel(
              userid: userid,
              itemName: Nameitem.text,
              tag: stringList,
              box: boxvalue,
              location: LocationName.text,
              quantity: counter.text,
              date: Localtime.toString(),
              image:
                  "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"));
          await DbHelp().adlocation(LocationModel(
              name: LocationName.text,
              userid: userid,
              date: Localtime.toString()));
          await DbHelp().adbox(BoxModel(
              userid: userid,
              name: boxvalue,
              date: Localtime.toString(),
              locationName: LocationName.text));
          await DbHelp().adtag(TagModel(
              userid: userid, name: stringList, date: Localtime.toString()));
          hideDialog();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            var controll = Get.find<HomeController>();
            controll.getData();
          });
          Get.back();
          Nameitem.clear();
          update();
          print('>>>>> Only Location : ${LocationName.text}');
        }
      }
    } else {
      print(
          ">>>>>>>>> ${stringList} ...... \n ${counter.text} <<<<<< \n ${Nameitem.text} ^^^^^^^^^ \n ${boxvalue} <><><><> \n ${locationvaluess}");
      await DbHelp().addlocation(AddItemModel(
          userid: userid,
          itemName: Nameitem.text,
          tag: stringList,
          box: boxvalue,
          location: locationvaluess,
          quantity: counter.text,
          date: Localtime.toString(),
          image:
              "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"));
      await DbHelp().adlocation(LocationModel(
          name: locationvaluess, userid: userid, date: Localtime.toString()));
      await DbHelp().adbox(BoxModel(
          userid: userid,
          name: boxvalue,
          date: Localtime.toString(),
          locationName: locationvaluess));
      await DbHelp().adtag(TagModel(
          userid: userid, name: stringList, date: Localtime.toString()));

      hideDialog();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        var controll = Get.find<HomeController>();
        controll.getData();
      });
      Get.back();
      Nameitem.clear();
      update();
    }
  }
}
