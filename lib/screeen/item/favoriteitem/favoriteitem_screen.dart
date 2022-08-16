import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/res/gradient.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/item/favoriteitem/favorite_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import '../../../base/base_view_view_model.dart';

class FavoriteScreen extends BaseView<FavoriteController> {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                ///ToDo 2

                Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                            controller.back();
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 21.w),
                              child: SvgPicture.asset('assets/svg/back.svg')),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 21.w),
                          child: GradientText(
                            "Favorite Items",
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
                              onTap: () {
                                controller.favoritelist?.sort((a, b) =>
                                    a.itemName!.compareTo(b.itemName!));
                                controller.update();
                              },
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
                              onTap: () {
                                controller.favoritelist?.sort(
                                    (a, b) => a.date!.compareTo(b.date!));
                                controller.update();
                              },
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
                              controller: controller.search,
                              style: robotoRegular.copyWith(
                                color: const Color(0xff111111),
                                fontSize: 14.sp,
                              ),
                              autofocus: false,
                              onSubmitted: (value) {
                                controller.searching();
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                hintText: 'Search your items in here.',
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
                              controller.showLoadingDialog();
                              if (controller.search.text.isNotEmpty) {
                                controller.search.clear();
                                controller.hideDialog();
                                controller.update();
                              } else if (controller.search.text.isEmpty) {
                                controller.getData();
                                controller.hideDialog();
                                controller.update();
                              }
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
                      height: 14.h,
                    ),
                    controller.favoritedatalist == null ||
                            controller.favoritedatalist!.isEmpty
                        ? Expanded(
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/image/Search.png',
                                  height: 92.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Add your favorite items here.',
                                  style: robotoRegular.copyWith(
                                    color: const Color(0xffa8a8a8),
                                    fontSize: 10.sp,
                                  ),
                                )
                              ],
                            )),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  controller.favoritedatalist != null
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .favoritedatalist?.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            var loc = controller
                                                .favoritedatalist?[index];
                                            var dates = loc?.date;
                                            var id = loc?.uid;
                                            print(">>>>>>> loc id ${id}");
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
                                            print("snonino $loc");
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 21.h,
                                                  right: 21.h,
                                                  top: 15.h),
                                              padding: const EdgeInsets.all(8),
                                              child: InkWell(
                                                onTap: () {
                                                  print('${loc?.uid}');
                                                  Get.toNamed(
                                                    RouterName.viewpage,
                                                    arguments: controller
                                                        .favoritelist?[index]
                                                        .toJson(),
                                                  );
                                                  // Get.toNamed(
                                                  //   RouterName.edititem,
                                                  //   arguments: controller
                                                  //       .favoritelist?[index]
                                                  //       .toJson(),
                                                  // );
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: const Color(
                                                                        0x3f000000),
                                                                    blurRadius:
                                                                        10.r,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            0),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.r),
                                                                child: loc?.image ==
                                                                        null
                                                                    ? Image.asset(
                                                                        'assets/image/ser_1.png',
                                                                        height: 180
                                                                            .h,
                                                                        width: 110
                                                                            .w,
                                                                        fit: BoxFit
                                                                            .cover)
                                                                    : Image
                                                                        .network(
                                                                        "${loc?.image}",
                                                                        height:
                                                                            180.h,
                                                                        width:
                                                                            110.w,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) {
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
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${loc?.itemName}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: robotoBold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18.sp),
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/svg/box_1.svg',
                                                                    height:
                                                                        12.h,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "BOX NUMBER/NAME",
                                                                      style: robotoMedium
                                                                          .copyWith(
                                                                        color: const Color(
                                                                            0xff7d7d7d),
                                                                        fontSize:
                                                                            8.sp,
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
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/svg/box_1.svg',
                                                                    height:
                                                                        12.h,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${loc?.boxName}",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: robotoBold
                                                                          .copyWith(
                                                                        fontSize:
                                                                            14.sp,
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
                                                                          left: 3
                                                                              .w),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        'assets/svg/loc.svg',
                                                                        height:
                                                                            12.h,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 7.w,
                                                                  ),
                                                                  Text(
                                                                    "LOCATION",
                                                                    style: robotoMedium
                                                                        .copyWith(
                                                                      color: const Color(
                                                                          0xff7d7d7d),
                                                                      fontSize:
                                                                          8.sp,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/svg/box_1.svg',
                                                                    height:
                                                                        12.h,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${loc?.locationName}",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: robotoBold
                                                                          .copyWith(
                                                                        fontSize:
                                                                            14.sp,
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
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Item Added on: ${outputDate}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: robotoMedium
                                                              .copyWith(
                                                            fontSize: 9.sp,
                                                            color: const Color(
                                                                0xff808080),
                                                          ),
                                                        ),
                                                        LikeButton(
                                                          size: 20.h,
                                                          isLiked:
                                                              loc?.favorite,
                                                          onTap:
                                                              (isLiked) async {
                                                            loc?.favorite =
                                                                !isLiked;
                                                            controller.update();
                                                            print(
                                                                '4444444${loc?.favorite}');
                                                            if (loc?.favorite ==
                                                                false) {
                                                              controller
                                                                  .showLoadingDialog();
                                                              await DbHelp().updateFavorite(
                                                                  AddItemModel(
                                                                      favorite:
                                                                          loc?.favorite),
                                                                  id);
                                                              print(
                                                                  'Value id true $loc?.favorite');
                                                              controller
                                                                  .update();
                                                              controller
                                                                  .getData();
                                                              controller
                                                                  .hideDialog();
                                                            } else {
                                                              print(
                                                                  'Value id true $loc?.favorite');
                                                              controller
                                                                  .hideDialog();
                                                            }

                                                            return Future.value(
                                                                loc?.favorite);
                                                          },
                                                          likeBuilder:
                                                              (isTapped) {
                                                            return SvgPicture
                                                                .asset(
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
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 2,
                                                      color: const Color(
                                                          0xffDEDEDE),
                                                    )
                                                  ],
                                                ),
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
                ))
              ],
            ),
          ),
          if (controller.isLoading == true)
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
      floatingActionButton: InkWell(
        onTap: () {
          Get.offNamed(
            RouterName.additem,
            arguments: {"favorite": true},
          );
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
