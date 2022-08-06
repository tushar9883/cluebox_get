import 'dart:convert';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends BaseView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: controller.userData == null || controller.userData!.isEmpty
          ? Material(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Wrap(
                  children: [
                    Container(
                      padding: REdgeInsets.all(10.0),
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                      // child: const CircularProgressIndicator(),
                      child: const SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SafeArea(
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: SvgPicture.asset(
                            'assets/svg/backgr.svg',
                            height: 124.h,
                          ))),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 14.w,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/logo.svg',
                              width: 150.w,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouterName.setting);
                            },
                            child: SvgPicture.asset(
                              'assets/svg/setting.svg',
                              height: 70.h,
                              // width: 150.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 21.w),
                        height: 54.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(62),
                          color: const Color(0xffe5e5e5),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(RouterName.search);
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 17.w, right: 5.w),
                                child: const Icon(
                                  Icons.search,
                                  color: Color(0xff5a5a5a),
                                ),
                              ),
                              Text(
                                'Search your item here.',
                                style: TextStyle(
                                  color: const Color(0xff5a5a5a),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              controller.tagList != null &&
                                      controller.tagList!.isNotEmpty == true
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 36.h,
                                          child: ListView.builder(
                                            shrinkWrap: false,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (controller
                                                        .tagList?.length)! >
                                                    5
                                                ? 5
                                                : controller.tagList?.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  print("101010101010");
                                                  var titlename = controller
                                                      .tagList?[index].name;
                                                  print(titlename);
                                                  Get.toNamed(
                                                    RouterName.tagitem,
                                                    arguments: controller
                                                        .tagList?[index]
                                                        .toJson(),
                                                  );
                                                  print(
                                                      'Item:- ${controller.tagList?[index]}');
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.r),
                                                    color: Colors.black,
                                                  ),
                                                  // margin: EdgeInsets.symmetric(horizontal: 4.w),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                    // vertical: 8.h,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller.tagList?[index]
                                                              .name ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          robotoBold.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 13.sp,
                                                        // fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14.h,
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),

                              ///TODO All Item changes
                              InkWell(
                                onTap: () {
                                  Get.toNamed(RouterName.allitem);
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 21.w),
                                  height: 133.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.r)),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/image/allitem.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8.h, right: 18.w),
                                            child: Text(
                                              "All Items",
                                              textAlign: TextAlign.center,
                                              style: robotoBold.copyWith(
                                                color: Colors.white,
                                                fontSize: 20.sp,
                                                // fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 18.w,
                                            right: 18.w,
                                            bottom: 2.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${controller.userData?.first.itemCount ?? "0"}",
                                              textAlign: TextAlign.center,
                                              style: robotoBold.copyWith(
                                                color: Colors.white,
                                                fontSize: 35.sp,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "View Items",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          robotoMedium.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 2.h),
                                                      child: Image.asset(
                                                        'assets/image/Arrow.png',
                                                        color: Colors.white,
                                                        width: 19.w,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(RouterName.myLocation);
                                      },
                                      child: Container(
                                        height: 100.w,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/image/location.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.w, bottom: 10.h),
                                              child: Text(
                                                "Location",
                                                style: robotoBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(RouterName.tag);
                                      },
                                      child: Container(
                                        height: 100.w,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/image/tag.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.w, bottom: 10.h),
                                              child: Text(
                                                "Tags",
                                                style: robotoBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(RouterName.favorite);
                                      },
                                      child: Container(
                                        height: 100.w,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/image/favorite.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.w, bottom: 10.h),
                                              child: Text(
                                                "Favorite",
                                                style: robotoBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 26.h,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 21.w),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Recent Items",
                                  style: robotoMedium.copyWith(
                                    color: const Color(0xffa0a0a0),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              controller.itemList != null
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.itemList?.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var loc = controller.itemList?[index];
                                        var dates = loc?.date;
                                        DateTime parseDate = DateFormat(
                                                "yyyy-MM-dd HH:mm:ss.SSS")
                                            .parse(dates!);
                                        var inputDate = DateTime.parse(
                                            parseDate.toString());
                                        var outputFormat =
                                            DateFormat('dd MMM yyyy');
                                        var outputDate =
                                            outputFormat.format(inputDate);
                                        print(outputDate);
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 21.h,
                                              right: 21.h,
                                              top: 15.h),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            border: Border.all(
                                              color: const Color(0xffe0e0e0),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                              0x3f000000),
                                                          blurRadius: 8.r,
                                                          offset: const Offset(
                                                              0, 0),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        child: loc?.image ==
                                                                null
                                                            ? Image.asset(
                                                                'assets/image/default.png',
                                                                height: 65.h,
                                                                width: 74.w,
                                                                fit: BoxFit
                                                                    .cover)
                                                            : Image.network(
                                                                "${loc?.image}",
                                                                height: 65.h,
                                                                width: 74.w,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image.asset(
                                                                      'assets/image/default.png',
                                                                      height:
                                                                          65.h,
                                                                      width:
                                                                          74.w,
                                                                      fit: BoxFit
                                                                          .cover);
                                                                },
                                                              )),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${loc?.itemName}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          robotoBold.copyWith(
                                                              fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      "${loc?.boxName}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style:
                                                          robotoMedium.copyWith(
                                                        fontSize: 12.sp,
                                                        color: const Color(
                                                            0xff111111),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      "Item Added on: ${outputDate}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          robotoMedium.copyWith(
                                                        fontSize: 9.sp,
                                                        color: const Color(
                                                            0xff808080),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.toNamed(RouterName.additem);
        },
        child: Container(
          width: 60.w,
          height: 60.w,
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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff4a00e0), Color(0xff8e2de2)],
            ),
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/svg/plus.svg', height: 36.h)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
