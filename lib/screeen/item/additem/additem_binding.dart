import 'dart:io';

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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../res/style.dart';
import '../../../services/storage_data.dart';

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
  String locationID = '';

  // String dropdownvalue = 'Item 1';
  BoxModel? boxvalue;
  LocationModel? locationvaluess;
  bool showBox = false;
  bool showLocation = false;
  bool hideBox = false;

  var userid = FirebaseAuth.instance.currentUser?.uid;

  List<LocationModel>? allLocList;
  List<BoxModel>? allBoxList;
  File? profileImage;
  final ImagePicker picker = ImagePicker();
  var imgUrl;

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

  submit() async {
    final _utcTime = DateTime.now().toUtc();
    final Localtime = _utcTime.toLocal();
    final taggs = tagController.getTags;
    var stringList = taggs?.join(", ");

    if (Nameitem.text.isEmpty) {
      toastbar('Item name is required');
    }
    // else if (tagController.getTags == null ||
    //     tagController.getTags!.isEmpty) {
    //   toastbar('Tags are required');
    // }
    else if (locationvaluess == null) {
      toastbar('Please select/add Location');
    } else if (locationvaluess?.name == 'Add Location' &&
        LocationName.text.isEmpty) {
      toastbar('Please enter Location Name');
    } else if (locationvaluess?.name == 'Add Location' &&
        BoxName.text.isEmpty) {
      toastbar('Please enter Box Name');
    } else if (locationvaluess?.name != 'Add Location' && boxvalue == null) {
      toastbar('Please select/add Box');
    } else if (boxvalue?.name == 'Add Box' && BoxName.text.isEmpty) {
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

      // print("id of location ${docrefLoc.id}");

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
      } else {
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
        image: imgUrl.toString(),
        boxId: selectedBox?.uid,
        locationId: selectedLocation?.uid,
      ));
      toastbar('SUCCESS', isSuccess: true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        var controll = Get.find<HomeController>();
        controll.getData();
      });
      Get.back();
    }
  }

  showPicker(context, String imageType) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(
                    'Gallery',
                    style: robotoBold.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    _imgFromGallery(imageType);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  'Camera',
                  style: robotoBold.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  _imgFromCamera(imageType);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future _imgFromGallery(String imageType) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
      switch (imageType) {
        case 'profilePic':
          profileImage = File(pickedImage.path);
          uplodeProfilePic();
          break;
      }
    }
    update();
  }

  //image picker
  Future _imgFromCamera(String imageType) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    if (pickedImage != null) {
      switch (imageType) {
        case 'profilePic':
          profileImage = File(pickedImage.path);
          uplodeProfilePic();

          break;
      }
    }
    update();
  }

  Future uplodeProfilePic() async {
    // setState(() {
    //   isLoading = !isLoading;
    // });
    print("iiiiiiiiiiiiiiiii${XFile(profileImage!.path)}");
    var result = await StorageData()
        .uploadFile(xfile: XFile(profileImage!.path), folderName: 'images');
    imgUrl = result["imageUrl"];
    print('immmmmmmmmmmmm-------------${imgUrl}');

    // if (mounted) {
    //   setState(() {
    //     isLoading = !isLoading;
    //   });
    // }
    update();
  }
}
