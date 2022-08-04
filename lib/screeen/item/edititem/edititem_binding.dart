import 'dart:io';
import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/services/storage_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EditItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditItemController(), fenix: true);
  }
}

class EditItemController extends BaseController {
  final counter = TextEditingController();
  final Nameitem = TextEditingController();
  final LocationName = TextEditingController();
  final BoxName = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();
  List<String> tags = [];

  List<LocationModel>? allLocList;

  AddItemModel? itemModel;

  String locationID = '';
  bool isFavorite = false;
  bool showBox = false;
  bool showLocation = false;
  bool hideBox = true;

  BoxModel? boxvalue;
  List<BoxModel>? allBoxList;
  LocationModel? locationvaluess;
  File? profileImage;
  final ImagePicker picker = ImagePicker();
  var imgUrl;
  var userid;
  List<AddItemModel>? itemList;
  List<TagModel>? tagList;
  var imagevalue;

  TagModel? tagModel;

  Future<void> getAllLoc(String userId) async {
    print("User ID >>>><<<<< $userId");
    var allData = await DbHelp().getAllLocation(userId);
    allLocList?.clear();
    allLocList = allData;
    allLocList!.insert(0, LocationModel(name: 'Add Location'));
    print("YESSSSSSSSSSSS");
    update();
  }

  Future<void> getBoxLocWise() async {
    print("LOC ID >>>><<<<< ${itemModel?.locationId}");
    var allData =
        await DbHelp().getBoxLocationWise(itemModel?.locationId ?? '');
    allBoxList?.clear();
    allBoxList = allData;
    allBoxList!.insert(0, BoxModel(name: 'Add Box'));
    // allLocList?.addAll(allData);
    update();
  }

  @override
  void onInit() {
    update();
    super.onInit();
    userid = FirebaseAuth.instance.currentUser?.uid;

    ///TODO Initstate ma async use karvo hoy tyare use thay function nichenu
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllLoc(userid);
      await getnewdata();
      await getBoxLocWise();
      await itemboxes();
    });
  }

  getnewdata() async {
    if (Get.arguments != null) {
      itemModel = AddItemModel.fromDB(Get.arguments);
      print("444444444444444 ${itemModel?.tag}");
      imgUrl = itemModel?.image;
      var name = itemModel?.itemName;
      var quantity = itemModel?.quantity;
      var like = itemModel?.favorite;
      Nameitem.text = name!;
      counter.text = quantity!;
      isFavorite = like!;
      locationvaluess = allLocList
          ?.firstWhere((element) => element.uid == itemModel?.locationId);

      if (itemModel?.tag != null) {
        tags.clear();
        for (var tagID in itemModel?.tag ?? []) {
          print('????????????????????$tagID');
          tagModel = await DbHelp().getTagData(tagID);
          tags.add(tagModel?.name ?? "");
          tagController.addTag = tagModel?.name ?? "";
        }
      }
      update();
    }
  }

  itemboxes() {
    print("010101010110 ${tagList?.first.name}");
    boxvalue =
        allBoxList?.firstWhere((element) => element.uid == itemModel?.boxId);
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.r),
        ),
      ),
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
                  // Get.until((route) => Get.currentRoute == RouterName.home);
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   var controll = Get.find<HomeController>();
                  //   controll.getData(userid);
                  //   controll.getAllTags(userid);
                  //   controll.getUserData(userid);
                  // });
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
    showLoadingDialog();
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
    hideDialog();
    update();
  }
}
