import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/res/color.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddItemController(), fenix: true);
  }
}

class AddItemController extends BaseController {
  final counter = TextEditingController();
  final Nameitem = TextEditingController();
  final LocationName = TextEditingController();
  final BoxName = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();
  String locationID = '';
  bool isFavorite = false;

  // String dropdownvalue = 'Item 1';
  BoxModel? boxvalue;
  LocationModel? locationvaluess;
  bool showBox = false;
  bool showLocation = false;
  bool hideBox = false;

  var userid = FirebaseAuth.instance.currentUser?.uid;

  List<LocationModel>? allLocList;
  List<BoxModel>? allBoxList;

  @override
  void onInit() {
    counter.text = "1";
    update();
    super.onInit();
    getAllLoc();
  }

  Future<void> getAllLoc() async {
    print("User ID >>>><<<<< $userid");
    var allData = await DbHelp().getAllLocation(userid ?? '');
    allLocList?.clear();
    allLocList = allData;
    allLocList!.insert(0, LocationModel(name: 'Add Location'));
    // allLocList?.addAll(allData);
    print("YESSSSSSSSSSSS");
    update();
  }

  Future<void> getBoxLocWise() async {
    print("LOC ID >>>><<<<< ${locationvaluess?.uid}");
    var allData = await DbHelp().getBoxLocationWise(locationvaluess?.uid ?? '');
    allBoxList?.clear();
    allBoxList = allData;
    allBoxList!.insert(0, BoxModel(name: 'Add Box'));
    // allLocList?.addAll(allData);
    update();
  }

  // additem() async {
  //   final _utcTime = DateTime.now().toUtc();
  //   final Localtime = _utcTime.toLocal();
  //   final taggs = tagController.getTags;
  //   var stringList = taggs?.join("");
  //
  //   showLoadingDialog();
  //   if (showLocation == true) {
  //     if (showBox == true) {
  //       if (LocationName.text.isEmpty) {
  //         hideDialog();
  //         toastbar("Location name is required");
  //       } else if (BoxName.text.isEmpty) {
  //         hideDialog();
  //         toastbar("Box name is required");
  //       } else {
  //         if (locationvaluess == 'Add Location' || boxvalue == 'Add New Box') {
  //           await DbHelp().addlocation(AddItemModel(
  //             userid: userid,
  //             itemName: Nameitem.text,
  //             tag: stringList,
  //             box: BoxName.text,
  //             location: LocationName.text,
  //             quantity: counter.text,
  //             date: Localtime.toString(),
  //             image:
  //                 "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80",
  //           ));
  //           await DbHelp().adlocation(LocationModel(
  //             name: LocationName.text,
  //             userid: userid,
  //             date: Localtime.toString(),
  //           ));
  //           await DbHelp().adbox(BoxModel(
  //             userid: userid,
  //             name: BoxName.text,
  //             date: Localtime.toString(),
  //             locationName: LocationName.text,
  //           ));
  //           await DbHelp().adtag(TagModel(
  //               userid: userid, name: stringList, date: Localtime.toString()));
  //           print(
  //               "?>?>?>?>>>>> ${LocationName.text} <?<?<??<?<?<?  ${BoxName.text}");
  //         }
  //         print(
  //             'Boxname : ${BoxName.text} >>> Location Name: ${LocationName.text}');
  //         hideDialog();
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           var controll = Get.find<HomeController>();
  //           controll.getData();
  //         });
  //         Get.back();
  //         Nameitem.clear();
  //         BoxName.clear();
  //         LocationName.clear();
  //         update();
  //       }
  //     } else if (showBox == false) {
  //       if (LocationName.text.isEmpty) {
  //         hideDialog();
  //         toastbar("Location name is required");
  //       } else {
  //         await DbHelp().addlocation(AddItemModel(
  //             userid: userid,
  //             itemName: Nameitem.text,
  //             tag: stringList,
  //             box: boxvalue,
  //             location: LocationName.text,
  //             quantity: counter.text,
  //             date: Localtime.toString(),
  //             image:
  //                 "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"));
  //         await DbHelp().adlocation(LocationModel(
  //             name: LocationName.text,
  //             userid: userid,
  //             date: Localtime.toString()));
  //         await DbHelp().adbox(BoxModel(
  //             userid: userid,
  //             name: boxvalue,
  //             date: Localtime.toString(),
  //             locationName: LocationName.text));
  //         await DbHelp().adtag(TagModel(
  //             userid: userid, name: stringList, date: Localtime.toString()));
  //         hideDialog();
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           var controll = Get.find<HomeController>();
  //           controll.getData();
  //         });
  //         Get.back();
  //         Nameitem.clear();
  //         update();
  //         print('>>>>> Only Location : ${LocationName.text}');
  //       }
  //     }
  //   } else {
  //     print(
  //         ">>>>>>>>> ${stringList} ...... \n ${counter.text} <<<<<< \n ${Nameitem.text} ^^^^^^^^^ \n ${boxvalue} <><><><> \n ${locationvaluess}");
  //     await DbHelp().addlocation(AddItemModel(
  //         userid: userid,
  //         itemName: Nameitem.text,
  //         tag: stringList,
  //         box: boxvalue,
  //         location: locationvaluess?.name,
  //         quantity: counter.text,
  //         date: Localtime.toString(),
  //         image:
  //             "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"));
  //     await DbHelp().adlocation(LocationModel(
  //         name: locationvaluess?.name,
  //         userid: userid,
  //         date: Localtime.toString()));
  //     await DbHelp().adbox(BoxModel(
  //         userid: userid,
  //         name: boxvalue,
  //         date: Localtime.toString(),
  //         locationName: locationvaluess?.name));
  //     await DbHelp().adtag(TagModel(
  //         userid: userid, name: stringList, date: Localtime.toString()));
  //
  //     hideDialog();
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       var controll = Get.find<HomeController>();
  //       controll.getData();
  //     });
  //     Get.back();
  //     Nameitem.clear();
  //     update();
  //   }
  // }

  submit(context) async {
    showLoadingDialog();
    final _utcTime = DateTime.now().toUtc();
    final Localtime = _utcTime.toLocal();
    final taggs = tagController.getTags;
    var stringList = taggs?.join(", ");

    if (Nameitem.text.isEmpty) {
      hideDialog();
      toastbar('Item name is required');
    } else if (locationvaluess == null) {
      hideDialog();
      toastbar('Please select/add Location');
    } else if (locationvaluess?.name == 'Add Location' &&
        LocationName.text.isEmpty) {
      hideDialog();
      toastbar('Please enter Location Name');
    } else if (locationvaluess?.name == 'Add Location' &&
        BoxName.text.isEmpty) {
      hideDialog();
      toastbar('Please enter Box Name');
    } else if (locationvaluess?.name != 'Add Location' && boxvalue == null) {
      hideDialog();
      toastbar('Please select/add Box');
    } else if (boxvalue?.name == 'Add Box' && BoxName.text.isEmpty) {
      hideDialog();
      toastbar('Please enter Box Name');
    } else {
      await DbHelp().adtag(TagModel(
          userid: userid, name: stringList, date: Localtime.toString()));
      BoxModel? selectedBox;
      LocationModel? selectedLocation;

      if (locationvaluess?.name == 'Add Location') {
        var docrefLoc = await DbHelp().adlocation(LocationModel(
          name: LocationName.text,
          userid: userid,
          date: Localtime.toString(),
        ));
        selectedLocation =
            LocationModel(uid: docrefLoc.id, name: LocationName.text);
        update();
      } else {
        selectedLocation = locationvaluess;
      }
      if (boxvalue?.name == 'Add Box' ||
          locationvaluess?.name == 'Add Location') {
        var docrefBox = await DbHelp().adbox(BoxModel(
          userid: userid,
          name: BoxName.text,
          date: Localtime.toString(),
          locationName: selectedLocation?.name,
          locationId: selectedLocation?.uid,
        ));
        update();
        selectedBox = BoxModel(uid: docrefBox.id, name: BoxName.text);
        hideDialog();
      } else {
        hideDialog();
        selectedBox = boxvalue;
      }

      await DbHelp().addItem(AddItemModel(
        userid: userid,
        itemName: Nameitem.text,
        tag: stringList,
        boxName: selectedBox?.name,
        locationName: selectedLocation?.name,
        quantity: counter.text,
        date: Localtime.toString(),
        image:
            "https://images.unsplash.com/photo-1535916707207-35f97e715e1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80",
        boxId: selectedBox?.uid,
        locationId: selectedLocation?.uid,
      ));
      hideDialog();
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.r))),
      title: Center(
        child: Text(
          'Item Added Successfully!',
          style: robotoBold.copyWith(
            color: Colors.black,
            fontSize: 20.sp,
          ),
        ),
      ),
      content: Image.asset(
        'assets/image/verified.gif',
        width: 154.w,
        height: 154.h,
      ),
      actions: [
        Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  Get.until((route) => Get.currentRoute == RouterName.home);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    var controll = Get.find<HomeController>();
                    controll.getData();
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 75.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3f000000),
                          blurRadius: 16.r,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff4A00E0),
                          Color(0xff8E2DE2),
                        ],
                        begin: Alignment(-1.0, 0),
                        end: Alignment(1, 1),
                      ),
                    ),
                    child: Text(
                      "OK",
                      textAlign: TextAlign.center,
                      style: robotoBold.copyWith(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 15.h,
            )
          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
