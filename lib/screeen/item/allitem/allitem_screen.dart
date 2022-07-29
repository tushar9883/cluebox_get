import 'dart:convert';
import 'package:clue_get/res/gradient.dart';
import 'package:clue_get/res/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import '../../../base/base_view_view_model.dart';
import 'allitem_binding.dart';

class AllItemScreen extends BaseView<AllItemController> {
  const AllItemScreen({Key? key}) : super(key: key);

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
                  child: GradientText(
                    "All Items",
                    style: robotoBold.copyWith(
                      color: const Color(0xff4A00E0),
                      fontSize: 22.sp,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff4A00E0),
                        Color(0xff8E2DE2),
                      ],
                      begin: Alignment(-1.0, 0),
                      end: Alignment(1, 1),
                    ),
                  ),
                ),
                PopupMenuButton(
                  padding: EdgeInsets.zero,
                  position: PopupMenuPosition.under,
                  child: SvgPicture.asset(
                    'assets/svg/filter.svg',
                    height: 70.h,
                  ),
                  onSelected: (value) {
                    value!;
                    print(value);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Center(
                        child: Text('A to Z',
                            style: robotoBold.copyWith(
                              color: Colors.black,
                              fontSize: 12.sp,
                            )),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text('Date Added',
                            style: robotoBold.copyWith(
                              color: Colors.black,
                              fontSize: 12.sp,
                            )),
                      ),
                    ),
                  ],
                )
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
                      style: robotoRegular.copyWith(
                        color: const Color(0xff111111),
                        fontSize: 14.sp,
                      ),
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
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
                ],
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.itemlist?.length ?? 0,
                      itemBuilder: (BuildContext context, index) {
                        var loc = controller.itemlist?[index];
                        return Container(
                          margin: EdgeInsets.only(
                              left: 21.h, right: 21.h, top: 15.h),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x3f000000),
                                              blurRadius: 10.r,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          child: Image.network(
                                            "${loc?.image}",
                                            height: 180.h,
                                            width: 110.w,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                                style: robotoMedium.copyWith(
                                                  color: Color(0xff7d7d7d),
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
                                                overflow: TextOverflow.clip,
                                                style: robotoBold.copyWith(
                                                  fontSize: 14.sp,
                                                  color:
                                                      const Color(0xff4a00e0),
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
                                                margin:
                                                    EdgeInsets.only(left: 3.w),
                                                child: SvgPicture.asset(
                                                  'assets/svg/loc.svg',
                                                  height: 12.h,
                                                )),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Text(
                                              "LOCATION",
                                              style: robotoMedium.copyWith(
                                                color: Color(0xff7d7d7d),
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
                                                overflow: TextOverflow.clip,
                                                style: robotoBold.copyWith(
                                                  fontSize: 14.sp,
                                                  color:
                                                      const Color(0xff4a00e0),
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
                                    "Item Added on: ${loc?.date}",
                                    overflow: TextOverflow.ellipsis,
                                    style: robotoMedium.copyWith(
                                      fontSize: 9.sp,
                                      color: const Color(0xff808080),
                                    ),
                                  ),
                                  LikeButton(
                                    size: 20.h,
                                    likeBuilder: (isTapped) {
                                      return SvgPicture.asset(
                                        isTapped
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
                                width: MediaQuery.of(context).size.width,
                                height: 2,
                                color: const Color(0xffDEDEDE),
                              )
                            ],
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
