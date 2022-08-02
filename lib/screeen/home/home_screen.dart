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
      body: SafeArea(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.tagList != null
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 34.h,
                                  ),
                                  SizedBox(
                                    height: 36.h,
                                    child: ListView.builder(
                                      shrinkWrap: false,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          (controller.tagList?.length)! > 5
                                              ? 5
                                              : controller.tagList?.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(left: 20.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.r),
                                            color: Colors.black,
                                          ),
                                          // margin: EdgeInsets.symmetric(horizontal: 4.w),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            // vertical: 8.h,
                                          ),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                print(
                                                    'Item:- ${controller.tagList?[index]}');
                                              },
                                              child: Text(
                                                controller
                                                        .tagList?[index].name ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: robotoBold.copyWith(
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
                                    height: 25.h,
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 21.w),
                          padding: EdgeInsets.only(bottom: 15.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x3f000000),
                                blurRadius: 16.r,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 21.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(RouterName.allitem);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        "${controller.itemList?.length ?? "0"}",
                                        textAlign: TextAlign.center,
                                        style: robotoBold.copyWith(
                                          color: const Color(0xff4a00e0),
                                          fontSize: 35.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "All Items",
                                        textAlign: TextAlign.center,
                                        style: robotoMedium.copyWith(
                                          color: const Color(0xff111111),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 21.w),
                                  height: 1,
                                  color: const Color(0xffCBCBCB),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //   width: 21.w,
                                    // ),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.red,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(RouterName.tag);
                                          },
                                          child: Text(
                                            "My Tags",
                                            textAlign: TextAlign.center,
                                            style: robotoBold.copyWith(
                                              color: const Color(0xff4A00E0),
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: const Color(0xffCBCBCB),
                                    ),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.green,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(RouterName.favorite);
                                          },
                                          child: Text(
                                            "Favorite Items",
                                            textAlign: TextAlign.center,
                                            style: robotoBold.copyWith(
                                              color: const Color(0xff4A00E0),
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 21.w,
                                    // ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 27.h,
                                // ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35.h,
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.itemList?.length,
                                itemBuilder: (BuildContext context, index) {
                                  var loc = controller.itemList?[index];
                                  var dates = loc?.date;
                                  DateTime parseDate =
                                      DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
                                          .parse(dates!);
                                  var inputDate =
                                      DateTime.parse(parseDate.toString());
                                  var outputFormat = DateFormat('dd MMM yyyy');
                                  var outputDate =
                                      outputFormat.format(inputDate);
                                  print(outputDate);
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 21.h, right: 21.h, top: 15.h),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
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
                                                    color:
                                                        const Color(0x3f000000),
                                                    blurRadius: 8.r,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  child: Image.network(
                                                    "${loc?.image}",
                                                    height: 65.h,
                                                    width: 74.w,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/image/default.png',
                                                          height: 65.h,
                                                          width: 74.w,
                                                          fit: BoxFit.cover);
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
                                                overflow: TextOverflow.ellipsis,
                                                style: robotoBold.copyWith(
                                                    fontSize: 16.sp),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                "${loc?.boxName}",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: robotoMedium.copyWith(
                                                  fontSize: 12.sp,
                                                  color:
                                                      const Color(0xff111111),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                "Item Added on: ${outputDate}",
                                                overflow: TextOverflow.ellipsis,
                                                style: robotoMedium.copyWith(
                                                  fontSize: 9.sp,
                                                  color:
                                                      const Color(0xff808080),
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
