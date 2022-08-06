import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/db/db_helper.dart';
import 'package:clue_get/res/gradient.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/tag/tag/tag_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagScreen extends BaseView<TagController> {
  const TagScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: controller.isLoading == true
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///ToDo 2 Tag
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.back();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 21.w),
                                  child:
                                      SvgPicture.asset('assets/svg/back.svg')),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 21.w),
                              child: GradientText(
                                "My Tags",
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
                                    hintText: 'Search your tags here.',
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
                                  if (controller.search.text.isEmpty) {
                                    Get.offNamed(RouterName.home);
                                  } else {
                                    controller.search.clear();
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
                        controller.tagList == null ||
                                controller.tagList!.isEmpty
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
                                      'Create the tags to group the relevant items.',
                                      style: robotoRegular.copyWith(
                                        color: const Color(0xffa8a8a8),
                                        fontSize: 10.sp,
                                      ),
                                    )
                                  ],
                                )),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 200.h),
                                  itemCount: controller.tagList?.length ?? 0,
                                  itemBuilder: (BuildContext context, index) {
                                    var loc = controller.tagList?[index];
                                    var id = loc?.userid;
                                    var uid = loc?.uid;
                                    return InkWell(
                                      onTap: () {
                                        var titlename =
                                            controller.tagList?[index].name;
                                        print(titlename);
                                        Get.toNamed(
                                          RouterName.tagitem,
                                          arguments: controller.tagList?[index]
                                              .toJson(),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 21.w,
                                                right: 21.w,
                                                top: 12.h),
                                            child: Slidable(
                                              endActionPane: ActionPane(
                                                motion: const ScrollMotion(),
                                                extentRatio: 0.20,
                                                children: [
                                                  SlidableAction(
                                                    backgroundColor:
                                                        Color(0xFFFE4A49),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.delete,
                                                    // label: 'Delete',
                                                    onPressed:
                                                        (BuildContext context) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
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
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.r))),
                                                            content: Text(
                                                              "Are you sure you want to delete this item from local and online server?\n\nYou won’t be able to find your item then.",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  poppinsMedium
                                                                      .copyWith(
                                                                color: const Color(
                                                                    0xff8f8f8f),
                                                                fontSize: 12.sp,
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
                                                                        controller
                                                                            .showLoadingDialog();
                                                                        print(
                                                                            'Delete');
                                                                        await DbHelp()
                                                                            .removeTag(uid!);
                                                                        WidgetsBinding
                                                                            .instance
                                                                            .addPostFrameCallback((_) {
                                                                          var controll =
                                                                              Get.find<TagController>();
                                                                          controll
                                                                              .getAllTags(id!);
                                                                        });
                                                                        controller
                                                                            .hideDialog();
                                                                        Navigator.of(context)
                                                                            .pop();
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
                                                                          borderRadius:
                                                                              BorderRadius.circular(9.r),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: const Color(0x3f000000),
                                                                              blurRadius: 16.r,
                                                                              offset: const Offset(0, 0),
                                                                            ),
                                                                          ],
                                                                          gradient:
                                                                              const LinearGradient(
                                                                            colors: [
                                                                              Color(0xff4A00E0),
                                                                              Color(0xff8E2DE2),
                                                                            ],
                                                                            begin:
                                                                                Alignment(-1.0, 0),
                                                                            end:
                                                                                Alignment(1, 1),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "Delete",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              robotoBold.copyWith(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18.sp,
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      controller.tagList?[index]
                                                              .name ??
                                                          '',
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style:
                                                          robotoMedium.copyWith(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 5.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.r),
                                                      color: Colors.black,
                                                    ),
                                                    child: Text(
                                                      controller.tagList?[index]
                                                              .tagItemCount
                                                              .toString() ??
                                                          '0',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          robotoBold.copyWith(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Container(
                                            color: const Color(0xffDEDEDE),
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          )
                                        ],
                                      ),
                                    );
                                  },
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    'Create Tag',
                    style: robotoBold.copyWith(
                      color: Colors.black,
                      fontSize: 26.sp,
                    ),
                  ),
                ),
                content: TextField(
                  cursorColor: const Color(0xff5566fd),
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
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff5566fd)),
                      )),
                ),
                actions: [
                  Column(
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: 110.w,
                              height: 40.h,
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
                                "Create",
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
            },
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
