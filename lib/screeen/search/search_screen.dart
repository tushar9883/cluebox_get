import 'dart:convert';

import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/search/search_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:simple_tags/simple_tags.dart';
import '../../base/base_view_view_model.dart';

class SearchScreen extends BaseView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 21.w),
                      child: SvgPicture.asset('assets/svg/back.svg')),
                ),
                Container(
                  margin: EdgeInsets.only(left: 21.w),
                  child: Text(
                    "Search Item",
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
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 21.w),
              height: 54.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(62),
                color: const Color(0xffe5e5e5),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  const Icon(
                    Icons.search,
                    color: const Color(0xff5a5a5a),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: const Color(0xff5566fd),
                      onSubmitted: (val) {
                        controller.showLoadingDialog();
                        controller.getSeachResult();
                        controller.isFirst = false;
                        controller.update();
                        controller.hideDialog();
                      },
                      controller: controller.search,
                      style: robotoRegular.copyWith(
                        color: const Color(0xff111111),
                        fontSize: 14.sp,
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search your item here.',
                        hintStyle: TextStyle(
                          color: const Color(0xff5a5a5a),
                          fontSize: 12.sp,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.search.clear();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xff5a5a5a),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            controller.isFirst == true
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 22.w),
                          child: Text(
                            "SEARCH HISTORY",
                            style: robotoMedium.copyWith(
                              color: const Color(0xff7d7d7d),
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 22.w),
                          child: SimpleTags(
                            content: controller.values,
                            wrapSpacing: 15,
                            wrapRunSpacing: 6,
                            onTagPress: (tag) {
                              print('pressed $tag');
                            },
                            onTagLongPress: (tag) {
                              print('long pressed $tag');
                            },
                            onTagDoubleTap: (tag) {
                              print('double tapped $tag');
                            },
                            tagContainerPadding: EdgeInsets.all(10.h),
                            tagTextStyle: robotoBold.copyWith(
                                color: const Color(0xff7d7d7d),
                                fontSize: 14.sp),
                            // tagIcon: Icon(Icons.clear, size: 12),
                            tagContainerDecoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xff7d7d7d),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            controller.searchModel == null
                // ? Expanded(
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset(
                //             'assets/image/Search.png',
                //             height: 92.h,
                //           ),
                //           SizedBox(
                //             height: 20.h,
                //           ),
                //           Text(
                //             'Let’s find the Clue for your item.',
                //             style: robotoRegular.copyWith(
                //               color: const Color(0xffa8a8a8),
                //               fontSize: 10.sp,
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   )
                ? const SizedBox.shrink()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.searchModel?.length,
                            itemBuilder: (BuildContext context, index) {
                              var loc = controller.searchModel?[index];
                              var id = loc?.uid;
                              var dates = loc?.date;
                              DateTime parseDate =
                                  DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
                                      .parse(dates!);
                              var inputDate =
                                  DateTime.parse(parseDate.toString());
                              var outputFormat = DateFormat('dd MMM yyyy');
                              var outputDate = outputFormat.format(inputDate);
                              print(outputDate);
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 21.h, right: 21.h, top: 15.h),
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      RouterName.edititem,
                                      arguments: controller.searchModel?[index]
                                          .toJson(),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                          0x3f000000),
                                                      blurRadius: 10.r,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  child: Image.network(
                                                    "${loc?.image}",
                                                    height: 180.h,
                                                    width: 110.w,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/image/ser_1.png',
                                                          height: 180.h,
                                                          width: 110.w,
                                                          fit: BoxFit.cover);
                                                    },
                                                  ),
                                                ),
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
                                                  overflow: TextOverflow.clip,
                                                  style: robotoBold.copyWith(
                                                      fontSize: 18.sp),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svg/box_1.svg',
                                                      height: 12.h,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "BOX NUMBER/NAME",
                                                        style: robotoMedium
                                                            .copyWith(
                                                          color:
                                                              Color(0xff7d7d7d),
                                                          fontSize: 8.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svg/box_1.svg',
                                                      height: 12.h,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${loc?.boxName}",
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style:
                                                            robotoBold.copyWith(
                                                          fontSize: 14.sp,
                                                          color: const Color(
                                                              0xff4a00e0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 3.w),
                                                        child: SvgPicture.asset(
                                                          'assets/svg/loc.svg',
                                                          height: 12.h,
                                                        )),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      "LOCATION",
                                                      style:
                                                          robotoMedium.copyWith(
                                                        color:
                                                            Color(0xff7d7d7d),
                                                        fontSize: 8.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svg/box_1.svg',
                                                      height: 12.h,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${loc?.locationName}",
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style:
                                                            robotoBold.copyWith(
                                                          fontSize: 14.sp,
                                                          color: const Color(
                                                              0xff4a00e0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Item Added on: ${outputDate}",
                                            overflow: TextOverflow.ellipsis,
                                            style: robotoMedium.copyWith(
                                              fontSize: 9.sp,
                                              color: const Color(0xff808080),
                                            ),
                                          ),
                                          LikeButton(
                                            size: 20.h,
                                            isLiked: loc?.favorite == true,
                                            onTap: (isLiked) async {
                                              loc?.favorite = !isLiked;
                                              controller.update();
                                              print(
                                                  "1111111111111111111111110.0000012131313");
                                              print(
                                                  '1111111111111111111111 ${loc?.favorite}');
                                              if (loc?.favorite == true) {
                                                controller.showLoadingDialog();
                                                await DbHelp().updateFavorite(
                                                    AddItemModel(
                                                      favorite: loc?.favorite,
                                                    ),
                                                    id);
                                                print(
                                                    'Value id true ${loc?.favorite}');
                                                controller.update();
                                                controller.getSeachResult();
                                                controller.hideDialog();
                                              } else {
                                                controller.showLoadingDialog();
                                                await DbHelp().updateFavorite(
                                                    AddItemModel(
                                                        favorite:
                                                            loc?.favorite),
                                                    id);
                                                print(
                                                    'Value id true $loc?.favorite');
                                                controller.update();
                                                controller.getSeachResult();
                                                controller.hideDialog();
                                              }
                                              return Future.value(
                                                  loc?.favorite);
                                            },
                                            likeBuilder: (isTapped) {
                                              return SvgPicture.asset(
                                                isTapped == true
                                                    ? 'assets/svg/likes_fill.svg'
                                                    : 'assets/svg/like.svg',
                                                height: 18.h,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 2,
                                        color: const Color(0xffDEDEDE),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
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
