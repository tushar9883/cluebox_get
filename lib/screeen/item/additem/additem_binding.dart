import 'dart:io';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:clue_get/res/color.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final counter = TextEditingController();
  final Nameitem = TextEditingController();
  final LocationName = TextEditingController();
  final BoxName = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();
  String locationID = '';
  bool isFavorite = false;
  BoxModel? boxvalue;
  LocationModel? locationvaluess;
  bool showBox = false;
  bool showLocation = false;
  bool hideBox = false;
  bool isLoading = false;
  List<LocationModel>? allLocList;
  List<BoxModel>? allBoxList;
  List<TagModel>? allTagsList;
  List<String> initalTags = [];

  File? profileImage;
  final ImagePicker picker = ImagePicker();
  var imgUrl;
  var userid;
  List<TagModel>? tagList;

  // var tag = Get.arguments['tag'];

  getArgdata() async {
    if (Get.arguments?['favorite'] != null) {
      isFavorite = Get.arguments['favorite'];
    } else {
      print("No Favorite Data");
    }
    if (Get.arguments?['tag'] != null) {
      initalTags = [Get.arguments['tag']];
      update();
    } else {
      print("No Tag Data");
    }
  }

  @override
  void onInit() {
    super.onInit();
    userid = FirebaseAuth.instance.currentUser?.uid;
    getAllLoc(userid);
    getAllTags(userid);
    counter.text = "1";
    print(">>>>>>>> favorite <<<<<<<<${isFavorite}");
    getArgdata();
    update();
  }

  back(BuildContext context) {
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controll = Get.find<HomeController>();
      controll.getData(userid!);
      controll.getAllTags(userid!);
    });
  }

  Future<void> getAllLoc(String userId) async {
    print("User ID >>>><<<<< $userId");
    var allData = await DbHelp().getAllLocation(userId);
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

  Future<void> getAllTags(String userId) async {
    var allTags = await DbHelp().getAllTagsByUser(userId);
    tagList?.clear();
    tagList = allTags;

    update();
  }

  showTagSearch() {
    var data = allTagsList?.where((element) => element.name!.contains('4'));
    print(data?.length);
  }

  submit(BuildContext context) async {
    showLoadingDialog();
    // isLoading = true;
    final _utcTime = DateTime.now().toUtc();
    final Localtime = _utcTime.toLocal();
    if (Nameitem.text.isEmpty) {
      // isLoading = false;
      hideDialog();
      toastbar('Item name is required');
    } else if (locationvaluess == null) {
      // isLoading = false;
      hideDialog();
      toastbar('Please select/add Location');
    } else if (locationvaluess?.name == 'Add Location' &&
        LocationName.text.isEmpty) {
      // isLoading = false;
      hideDialog();
      toastbar('Please enter Location Name');
    } else if (locationvaluess?.name == 'Add Location' &&
        BoxName.text.isEmpty) {
      // isLoading = false;
      hideDialog();
      toastbar('Please enter Box Name');
    } else if (locationvaluess?.name != 'Add Location' && boxvalue == null) {
      // isLoading = false;
      hideDialog();
      toastbar('Please select/add Box');
    } else if (boxvalue?.name == 'Add Box' && BoxName.text.isEmpty) {
      // isLoading = false;
      hideDialog();
      toastbar('Please enter Box Name');
    } else {
      List<String> tagIds = [];
      for (var tag in tagController.getTags ?? []) {
        TagModel? tagData = await DbHelp()
            .getTagData('${tag.toString().toLowerCase()}_$userid');

        if (tagData != null) {
          //Tag is already there in db
          tagIds.add(tagData.uid ?? "");
          tagData.tagItemCount = (tagData.tagItemCount ?? 0) + 1;
          await DbHelp().addtag(tagData);
          print("Present___________");
        } else {
          //Tag is not in db
          await DbHelp().addtag(TagModel(
              userid: userid,
              tagItemCount: 1,
              name: tag.toString().toLowerCase(),
              date: Localtime.toString(),
              uid: '${tag.toString().toLowerCase()}_$userid'));
          tagIds.add('${tag.toString().toLowerCase()}_$userid');
          print("Not Present___________");
        }
      }

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
        // isLoading = false;
        hideDialog();
      } else {
        selectedLocation = locationvaluess;
        // isLoading = false;
        hideDialog();
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
        // isLoading = false;
        hideDialog();
      } else {
        selectedBox = boxvalue;
        update();
        // isLoading = false;
        hideDialog();
      }
      await DbHelp().addItem(AddItemModel(
          userid: userid,
          itemName: Nameitem.text,
          // tag: tagController.getTags,
          tag: tagIds,
          boxName: selectedBox?.name,
          locationName: selectedLocation?.name,
          quantity: counter.text,
          date: Localtime.toString(),
          image: imgUrl,
          boxId: selectedBox?.uid,
          locationId: selectedLocation?.uid,
          favorite: isFavorite));

      List<UserModel>? userData = await DbHelp().getuserData(userid);

      if (userData.isNotEmpty) {
        //To update item count of this user
        userData.first.itemCount = (userData.first.itemCount ?? 0) + 1;
        await DbHelp().udpateUserData(userData.first, userData.first.uid);
        print("User itemCount updated___________");
      }

      // isLoading = false;
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
                    controll.getData(userid);
                    controll.getAllTags(userid);
                    controll.getUserData(userid);
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
        // return alert;
        return WillPopScope(onWillPop: () async => false, child: alert);
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
