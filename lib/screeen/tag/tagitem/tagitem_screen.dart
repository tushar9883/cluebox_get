import 'dart:convert';

import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/tag/tagitem/tagitem_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

class TagItemScreen extends BaseView<TagItemController> {
  const TagItemScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          // controller.itemList == null || controller.itemList!.isEmpty
          controller.isLoading == true
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
                  child: Column(
                    children: [
                      ///TODo 1 Blank
                      // Expanded(
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           InkWell(
                      //             onTap: () {
                      //               Navigator.of(context).pop();
                      //             },
                      //             child: Container(
                      //                 margin: EdgeInsets.only(left: 21.w),
                      //                 child: SvgPicture.asset('assets/svg/back.svg')),
                      //           ),
                      //           InkWell(
                      //             onTap: (){},
                      //             child: Row(
                      //               children: [
                      //                 Container(
                      //                     margin: EdgeInsets.only(left: 21.w),
                      //                     child: Text(
                      //                       "@Alley",
                      //                       style: robotoBold.copyWith(
                      //                         color: Colors.black,
                      //                         fontSize: 18.sp,
                      //                       ),
                      //                     )),
                      //                 SizedBox(width: 5.w,),
                      //                 SvgPicture.asset('assets/svg/edit.svg',height: 12.h,)
                      //               ],
                      //             ),
                      //           ),
                      //           SvgPicture.asset(
                      //             'assets/svg/layout.svg',
                      //             height: 70.h,
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: 14.h,
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.symmetric(horizontal: 21.w),
                      //         height: 54.h,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(62),
                      //           color: const Color(0xffe5e5e5),
                      //         ),
                      //         child: TextField(
                      //           cursorColor: const Color(0xff5566fd),
                      //           style: robotoRegular.copyWith(
                      //             color: const Color(0xff111111),
                      //             fontSize: 14.sp,
                      //           ),
                      //           autofocus: false,
                      //           keyboardType: TextInputType.text,
                      //           textInputAction: TextInputAction.go,
                      //           decoration:  InputDecoration(
                      //             hintText: 'Search your items in “alley” here.',
                      //             hintStyle: TextStyle(
                      //               color: Color(0xff5a5a5a),
                      //               fontSize: 12.sp,
                      //             ),
                      //             border: InputBorder.none,
                      //             prefixIcon: const Icon(
                      //               Icons.search,
                      //               color: Color(0xff5a5a5a),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       // Container(
                      //       //   margin: EdgeInsets.symmetric(horizontal: 21.w),
                      //       //   height: 54.h,
                      //       //   decoration: BoxDecoration(
                      //       //     borderRadius: BorderRadius.circular(62),
                      //       //     color: const Color(0xffe5e5e5),
                      //       //   ),
                      //       //   child: Row(
                      //       //     children: [
                      //       //       Container(
                      //       //         margin: EdgeInsets.only(left: 17.w, right: 5.w),
                      //       //         child: const Icon(
                      //       //           Icons.search,
                      //       //           color: Color(0xff5a5a5a),
                      //       //         ),
                      //       //       ),
                      //       //       Text(
                      //       //         'Search your items in “alley” here.',
                      //       //         style: TextStyle(
                      //       //           color: const Color(0xff5a5a5a),
                      //       //           fontSize: 12.sp,
                      //       //         ),
                      //       //       ),
                      //       //     ],
                      //       //   ),
                      //       // ),
                      //       SizedBox(
                      //         height: 10.h,
                      //       ),
                      //       Expanded(
                      //         child: Center(
                      //             child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Image.asset(
                      //               'assets/image/Search.png',
                      //               height: 92.h,
                      //             ),
                      //             SizedBox(
                      //               height: 20.h,
                      //             ),
                      //             Text(
                      //               'Add relevant items to “Alley”.',
                      //               style: robotoRegular.copyWith(
                      //                 color: const Color(0xffa8a8a8),
                      //                 fontSize: 10.sp,
                      //               ),
                      //             )
                      //           ],
                      //         )),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      ///TODO 2 Screen

                      Expanded(
                        child: Column(
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
                                      child: SvgPicture.asset(
                                          'assets/svg/back.svg')),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Center(
                                            child: Text(
                                              'Change Tag Name',
                                              style: robotoBold.copyWith(
                                                color: Colors.black,
                                                fontSize: 26.sp,
                                              ),
                                            ),
                                          ),
                                          content: TextField(
                                            cursorColor:
                                                const Color(0xff5566fd),
                                            style: poppinsMedium.copyWith(
                                              fontSize: 14.sp,
                                            ),
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.go,
                                            decoration: InputDecoration(
                                              hintText: 'Tag Name',
                                              hintStyle: poppinsMedium.copyWith(
                                                color: const Color(0xff111111),
                                                fontSize: 10.sp,
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff5566fd)),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Column(
                                              children: [
                                                Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 93.w,
                                                      height: 46.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                0x3f000000),
                                                            blurRadius: 16.r,
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                          ),
                                                        ],
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            Color(0xff4A00E0),
                                                            Color(0xff8E2DE2),
                                                          ],
                                                          begin: Alignment(
                                                              -1.0, 0),
                                                          end: Alignment(1, 1),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Save",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            robotoBold.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 21.w),
                                        child: Text(
                                          "@${controller.tagModel?.name}",
                                          style: robotoBold.copyWith(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SvgPicture.asset(
                                        'assets/svg/edit.svg',
                                        height: 12.h,
                                      )
                                    ],
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
                                        child: Text(
                                          'A to Z',
                                          style: robotoBold.copyWith(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: Center(
                                        child: Text(
                                          'Date Added',
                                          style: robotoBold.copyWith(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                          ),
                                        ),
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
                                        hintText:
                                            'Search your items in “alley” here.',
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
                            controller.itemList == null ||
                                    controller.itemList!.isEmpty
                                ? Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/image/Search.png',
                                            height: 92.h,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            'Add relevant items to “Alley”.',
                                            style: robotoRegular.copyWith(
                                              color: const Color(0xffa8a8a8),
                                              fontSize: 10.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.itemList?.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var data =
                                                  controller.itemList?[index];
                                              var boxid = data?.boxId;
                                              var locationid = data?.locationId;
                                              var id = data?.uid;
                                              var dates = data?.date;
                                              DateTime parseDate = DateFormat(
                                                      "yyyy-MM-dd HH:mm:ss.SSS")
                                                  .parse(dates!);
                                              var inputDate = DateTime.parse(
                                                  parseDate.toString());
                                              var outputFormat =
                                                  DateFormat('dd MMM yyyy');
                                              var outputDate = outputFormat
                                                  .format(inputDate);
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    left: 21.w,
                                                    right: 21.w,
                                                    top: 15.h),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Slidable(
                                                  endActionPane: ActionPane(
                                                    motion:
                                                        const ScrollMotion(),
                                                    extentRatio: 0.25,
                                                    children: [
                                                      SlidableAction(
                                                        backgroundColor:
                                                            Color(0xFFFE4A49),
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                        label: 'Delete',
                                                        onPressed: (BuildContext
                                                            context) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Center(
                                                                  child: Text(
                                                                    'Delete Item?',
                                                                    style: robotoBold
                                                                        .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          26.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        10.r),
                                                                  ),
                                                                ),
                                                                content: Text(
                                                                  "Are you sure you want to delete this item from local and online server?\n\nYou won’t be able to find your item then.",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: poppinsMedium
                                                                      .copyWith(
                                                                    color: const Color(
                                                                        0xff8f8f8f),
                                                                    fontSize:
                                                                        12.sp,
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  Column(
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            controller.showLoadingDialog();
                                                                            print('Delete');
                                                                            DbHelp().removeItem(id!);
                                                                            DbHelp().removeBox(boxid!);
                                                                            DbHelp().removeLocation(locationid!);
                                                                            controller.deleteitem();
                                                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                              var controll = Get.find<TagItemController>();
                                                                              controll.getAllItemsFromTag();
                                                                            });
                                                                            controller.hideDialog();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            width:
                                                                                93.w,
                                                                            height:
                                                                                46.h,
                                                                            decoration:
                                                                                BoxDecoration(
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
                                                                            child:
                                                                                Text(
                                                                              "Delete",
                                                                              textAlign: TextAlign.center,
                                                                              style: robotoBold.copyWith(
                                                                                color: Colors.white,
                                                                                fontSize: 18.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15.h,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        RouterName.edititem,
                                                        arguments: controller
                                                            .itemList?[index]
                                                            .toJson(),
                                                      );
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
                                                                        offset: const Offset(
                                                                            0,
                                                                            0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.r),
                                                                    child: data?.image ==
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
                                                                            data?.image ??
                                                                                '',
                                                                            height:
                                                                                180.h,
                                                                            width:
                                                                                110.w,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) {
                                                                              return Image.asset('assets/image/ser_1.png', height: 180.h, width: 110.w, fit: BoxFit.cover);
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
                                                                    data?.itemName ??
                                                                        "",
                                                                    // newData[index]['title'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: robotoBold.copyWith(
                                                                        fontSize:
                                                                            18.sp),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
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
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          "BOX NUMBER/NAME",
                                                                          style:
                                                                              robotoMedium.copyWith(
                                                                            color:
                                                                                Color(0xff7d7d7d),
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
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          data?.boxName ??
                                                                              '',
                                                                          // newData[index]
                                                                          //     ['text'],
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.clip,
                                                                          style:
                                                                              robotoBold.copyWith(
                                                                            fontSize:
                                                                                14.sp,
                                                                            color:
                                                                                const Color(0xff4a00e0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                3.w),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          'assets/svg/loc.svg',
                                                                          height:
                                                                              12.h,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            7.w,
                                                                      ),
                                                                      Text(
                                                                        "LOCATION",
                                                                        style: robotoMedium
                                                                            .copyWith(
                                                                          color:
                                                                              Color(0xff7d7d7d),
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
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          data?.locationName ??
                                                                              '',
                                                                          // newData[index]
                                                                          //     ['type'],
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.clip,
                                                                          style:
                                                                              robotoBold.copyWith(
                                                                            fontSize:
                                                                                14.sp,
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
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Item Added on: ${outputDate}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  robotoMedium
                                                                      .copyWith(
                                                                fontSize: 9.sp,
                                                                color: const Color(
                                                                    0xff808080),
                                                              ),
                                                            ),
                                                            LikeButton(
                                                              size: 20.h,
                                                              likeBuilder:
                                                                  (isTapped) {
                                                                return SvgPicture
                                                                    .asset(
                                                                  data?.favorite ??
                                                                          false
                                                                      // isTapped
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
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 2,
                                                          color: const Color(
                                                              0xffDEDEDE),
                                                        )
                                                      ],
                                                    ),
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
                      )
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
