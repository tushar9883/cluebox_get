import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/screeen/item/additem/additem_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../base/base_view_view_model.dart';
import '../../../model/location_model.dart';
import '../../../router/router_name.dart';
import '../../home/home_binding.dart';

class AdditemScreen extends BaseView<AddItemController> {
  const AdditemScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var id = controller.userid;
        // Get.until((route) => Get.currentRoute == RouterName.home);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          var controll = Get.find<HomeController>();
          controll.getData(id);
          controll.getAllTags(id);
          controll.getUserData(id);
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body:
            // controller.allLocList == null || controller.allLocList!.isEmpty

            Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.back(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 21.w),
                            child: SvgPicture.asset('assets/svg/back.svg')),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 21.w),
                        child: Text(
                          "Add Item",
                          style: robotoBold.copyWith(
                            color: Colors.black,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svg/layout.svg',
                        height: 70.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 13.h,
                          ),
                          controller.imgUrl != null
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 21.h),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              controller.imgUrl.toString(),
                                              height: 194.h,
                                              width: 372.w,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              width: 372.w,
                                              height: 194.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14.r),
                                                color: const Color(0x99ffffff),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.showPicker(
                                            context, 'profilePic');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 153.w,
                                        height: 38.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.w,
                                          ),
                                          color: Colors.transparent,
                                        ),
                                        child: Text(
                                          "Change Image",
                                          style: robotoBold.copyWith(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 21.h),
                                      child:
                                          Image.asset('assets/image/check.png'),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.showPicker(
                                            context, 'profilePic');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 153.w,
                                        height: 38.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.w,
                                          ),
                                          color: Colors.transparent,
                                        ),
                                        child: Text(
                                          "Add Item Image",
                                          style: robotoBold.copyWith(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 16.w),
                                child: LikeButton(
                                  size: 30.h,
                                  isLiked: controller.isFavorite,
                                  onTap: (isLiked) {
                                    controller.isFavorite = !isLiked;
                                    controller.update();
                                    print(
                                        '22222222222222222${controller.isFavorite}');
                                    return Future.value(controller.isFavorite);
                                  },
                                  likeBuilder: (isTapped) {
                                    return SvgPicture.asset(
                                      isTapped
                                          ? 'assets/svg/likes_fill.svg'
                                          : 'assets/svg/like.svg',
                                      height: 18.h,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 38.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Item Name",
                                  style: robotoBold.copyWith(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                TextField(
                                  cursorColor: const Color(0xff5566fd),
                                  controller: controller.Nameitem,
                                  style: robotoRegular.copyWith(
                                    color: const Color(0xff111111),
                                    fontSize: 14.sp,
                                  ),
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff5566fd)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Text(
                                  "Tags",
                                  style: robotoBold.copyWith(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                TextFieldTags(
                                  initialTags: controller.initalTags,
                                  textfieldTagsController:
                                      controller.tagController,
                                  textSeparators: const [' ', ','],
                                  letterCase: LetterCase.normal,
                                  validator: (String tag) {
                                    if (tag == 'php') {
                                      return 'No, please just no';
                                    } else if (controller.tagController.getTags!
                                        .contains(tag)) {
                                      return 'you already entered that';
                                    }
                                    return null;
                                  },
                                  inputfieldBuilder: (context, tec, fn, error,
                                      onChanged, onSubmitted) {
                                    return ((context, sc, tags, onTagDelete) {
                                      return TextField(
                                        controller: tec,
                                        cursorColor: const Color(0xff5566fd),
                                        style: robotoRegular.copyWith(
                                          color: const Color(0xff111111),
                                          fontSize: 14.sp,
                                        ),
                                        focusNode: fn,
                                        decoration: InputDecoration(
                                          hintText: controller
                                                  .tagController.hasTags
                                              ? ''
                                              : "Use comma to separate tags",
                                          errorText: error,
                                          // prefixIconConstraints: BoxConstraints(maxWidth: distanceToField * 0.74),
                                          prefixIcon: tags.isNotEmpty
                                              ? SingleChildScrollView(
                                                  controller: sc,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                      children: tags
                                                          .map((String tag) {
                                                    return Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                        color:
                                                            Color(0xffD3D3D3),
                                                      ),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 5.h),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            child: Text(
                                                              '#$tag',
                                                              style:
                                                                  robotoRegular
                                                                      .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              print(
                                                                  "$tag selected");
                                                            },
                                                          ),
                                                          SizedBox(width: 4.w),
                                                          InkWell(
                                                            child: const Icon(
                                                              Icons.cancel,
                                                              size: 14.0,
                                                              color: Color(
                                                                  0xff111111),
                                                              // color: Color.fromARGB(
                                                              //     255, 233, 233, 233),
                                                            ),
                                                            onTap: () {
                                                              onTagDelete(tag);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }).toList()),
                                                )
                                              : null,
                                        ),
                                        onChanged: onChanged,
                                        onSubmitted: onSubmitted,
                                      );
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print(controller.allLocList?.length);
                                      },
                                      child: Text(
                                        "Location",
                                        style: robotoBold.copyWith(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              // title: Text('Welcome'),
                                              title: Text(
                                                'Where is the box located?',
                                                style: robotoRegular.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 20.w,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x3f000000),
                                              blurRadius: 16.r,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xff4a00e0),
                                              Color(0xff8e2de2)
                                            ],
                                          ),
                                        ),
                                        child: Text(
                                          '?',
                                          textAlign: TextAlign.center,
                                          style: robotoBold.copyWith(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                DropdownButton(
                                  value: controller.locationvaluess,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: robotoRegular.copyWith(
                                    color: const Color(0xff111111),
                                    fontSize: 14.sp,
                                  ),
                                  underline: Container(
                                    height: 1.h,
                                    color: const Color(0xFF999999),
                                  ),
                                  hint: const Text('Select Location'),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: controller.allLocList
                                      ?.map((LocationModel itemsss) {
                                    return DropdownMenuItem(
                                      value: itemsss,
                                      child: Text(itemsss.name ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    controller.locationvaluess =
                                        (newValue as LocationModel);
                                    print(
                                        '----------------${controller.locationvaluess?.name}');
                                    if (newValue.name == 'Add Location') {
                                      controller.showLocation = true;
                                      controller.showBox = true;
                                      controller.hideBox = false;
                                      controller.update();
                                      print(
                                          '>>>>>>${controller.locationvaluess}');
                                    } else {
                                      controller.showLocation = false;
                                      controller.showBox = false;
                                      controller.hideBox = true;
                                      controller.boxvalue = null;
                                      controller.LocationName.clear();
                                      controller.BoxName.clear();
                                      controller.getBoxLocWise();
                                      controller.update();
                                      print(controller.locationvaluess);
                                    }
                                  },
                                ),

                                ///ToDo Location TextField
                                Visibility(
                                  visible: controller.showLocation,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Text(
                                        "Location Name",
                                        style: robotoBold.copyWith(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      TextField(
                                        cursorColor: const Color(0xff5566fd),
                                        controller: controller.LocationName,
                                        style: robotoRegular.copyWith(
                                          color: const Color(0xff111111),
                                          fontSize: 14.sp,
                                        ),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff5566fd)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Visibility(
                                  visible: controller.hideBox,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Box Number/Name",
                                            style: robotoBold.copyWith(
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    // title: Text('Welcome'),
                                                    content: Text(
                                                      'Where are you putting your items?',
                                                      style: robotoRegular
                                                          .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 20.w,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0x3f000000),
                                                    blurRadius: 16.r,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xff4a00e0),
                                                    Color(0xff8e2de2)
                                                  ],
                                                ),
                                              ),
                                              child: Text(
                                                '?',
                                                textAlign: TextAlign.center,
                                                style: robotoBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      ///TODo AddValue
                                      DropdownButton(
                                        value: controller.boxvalue,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: robotoRegular.copyWith(
                                          color: const Color(0xff111111),
                                          fontSize: 14.sp,
                                        ),
                                        underline: Container(
                                          height: 1.h,
                                          color: const Color(0xFF999999),
                                        ),
                                        hint: const Text('Select Box'),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: controller.allBoxList
                                            ?.map((BoxModel items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.name ?? ''),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          controller.boxvalue =
                                              (newValue as BoxModel);
                                          if (newValue.name == 'Add Box') {
                                            controller.showBox = true;
                                            controller.update();
                                            print(
                                                '>>>>>>${controller.boxvalue}');
                                          } else {
                                            controller.showBox = false;
                                            controller.update();
                                            print(controller.boxvalue);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                    ],
                                  ),
                                ),

                                ///TODo Box Name TextField

                                Visibility(
                                  visible: controller.showBox,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Box Name",
                                        style: robotoBold.copyWith(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      TextField(
                                        cursorColor: const Color(0xff5566fd),
                                        controller: controller.BoxName,
                                        style: robotoRegular.copyWith(
                                          color: const Color(0xff111111),
                                          fontSize: 14.sp,
                                        ),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff5566fd)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 25.h,
                                ),
                                Text(
                                  "Quantity",
                                  style: robotoBold.copyWith(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80.w,
                                      child: TextField(
                                        maxLines: 1,
                                        cursorColor: const Color(0xff5566fd),
                                        style: robotoRegular.copyWith(
                                          color: const Color(0xff111111),
                                          fontSize: 14.sp,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff5566fd)),
                                          ),
                                        ),
                                        controller: controller.counter,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          // controller.counter.text = value;
                                          // controller.update();
                                          print(controller.counter.text);
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        int currentValue =
                                            int.parse(controller.counter.text);
                                        currentValue++;
                                        controller.counter.text =
                                            (currentValue).toString();
                                        controller.update();
                                      },
                                      child: Container(
                                        width: 30.w,
                                        height: 30.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: Colors.black,
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                    'assets/svg/inc.svg',
                                                    height: 15.h))
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        int currentValue =
                                            int.parse(controller.counter.text);
                                        print("Setting state");
                                        currentValue--;
                                        controller.counter.text =
                                            (currentValue > 1
                                                    ? currentValue
                                                    : 1)
                                                .toString();
                                        controller.update();
                                      },
                                      child: Container(
                                        width: 30.w,
                                        height: 30.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: Colors.black,
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                    'assets/svg/dec.svg',
                                                    width: 15.h))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () async {
                                      // await controller.additem();
                                      await controller.submit(context);
                                    },
                                    child: Container(
                                      width: 177.w,
                                      height: 48.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(9.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x3f000000),
                                            blurRadius: 16.r,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xff4a00e0),
                                            Color(0xff8e2de2)
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Add Item",
                                          style: robotoBold.copyWith(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (controller.allLocList == null ||
                controller.allLocList!.isEmpty ||
                controller.isLoading == true)
              Container(
                color: Colors.black.withOpacity(0.1),
                child: Center(
                  child: Wrap(
                    children: [
                      Container(
                        padding: REdgeInsets.all(10.0),
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: const SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
