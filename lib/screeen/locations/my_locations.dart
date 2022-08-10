import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/gradient.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_locations_binding.dart';

class MyLocation extends BaseView<MyLocationController> {
  const MyLocation({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///ToDo 2 Location
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
                                child: SvgPicture.asset('assets/svg/back.svg')),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 21.w),
                            child: GradientText(
                              "All Locations",
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
                                  controller.mydataLocationList?.sort(
                                      (a, b) => a.name!.compareTo(b.name!));
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
                                  controller.mydataLocationList?.sort(
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
                                onSubmitted: (value) {
                                  controller.searching();
                                },
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  hintText: 'Search your locations here.',
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
                                var id = controller.userid;
                                if (controller.search.text.isNotEmpty) {
                                  controller.search.clear();
                                  controller.hideDialog();
                                  controller.update();
                                } else if (controller.search.text.isEmpty) {
                                  controller.getAllLocations(id!);
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
                      controller.mydataLocationList == null ||
                              controller.mydataLocationList!.isEmpty
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
                                    'Create the locations to group the relevant items.',
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
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 200.h),
                                itemCount:
                                    controller.mydataLocationList?.length ?? 0,
                                itemBuilder: (BuildContext context, index) {
                                  return InkWell(
                                    onTap: () {
                                      var titlename = controller
                                          .mydataLocationList?[index].name;
                                      print(titlename);
                                      Get.toNamed(
                                        RouterName.myBoxes,
                                        arguments: controller
                                            .mydataLocationList?[index]
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  controller
                                                          .mydataLocationList?[
                                                              index]
                                                          .name ??
                                                      '',
                                                  overflow: TextOverflow.clip,
                                                  style: robotoMedium.copyWith(
                                                      fontSize: 16.sp,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              // Container(
                                              //   padding:
                                              //   EdgeInsets.symmetric(
                                              //     horizontal: 10.w,
                                              //     vertical: 5.h,
                                              //   ),
                                              //   decoration: BoxDecoration(
                                              //     borderRadius:
                                              //     BorderRadius
                                              //         .circular(25.r),
                                              //     color: Colors.black,
                                              //   ),
                                              //   child: Text(
                                              //     controller
                                              //         .mydataLocationList?[index]
                                              //         .tagCount
                                              //         .toString() ??
                                              //         '0',
                                              //     overflow: TextOverflow
                                              //         .ellipsis,
                                              //     style:
                                              //     robotoBold.copyWith(
                                              //         fontSize: 12.sp,
                                              //         color: Colors
                                              //             .white),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Container(
                                          color: const Color(0xffDEDEDE),
                                          height: 1,
                                          width:
                                              MediaQuery.of(context).size.width,
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
      // lgActionButton: InkWell(
      //   onTap: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Center(
      //             child: Text(
      //               'Create Location',
      //               style: robotoBold.copyWith(
      //                 color: Colors.black,
      //                 fontSize: 26.sp,
      //               ),
      //             ),
      //           ),
      //           content: TextField(
      //             cursorColor: const Color(0xff5566fd),
      //             style: poppinsMedium.copyWith(
      //               fontSize: 14.sp,
      //             ),
      //             keyboardType: TextInputType.text,
      //             textInputAction: TextInputAction.go,
      //             decoration: InputDecoration(
      //                 hintText: 'Location Name',
      //                 hintStyle: poppinsMedium.copyWith(
      //                   color: const Color(0xff111111),
      //                   fontSize: 10.sp,
      //                 ),
      //                 focusedBorder: const UnderlineInputBorder(
      //                   borderSide: BorderSide(color: Color(0xff5566fd)),
      //                 )),
      //           ),
      //           actions: [
      //             Column(
      //               children: [
      //                 Center(
      //                   child: InkWell(
      //                     onTap: () {
      //                       Navigator.of(context).pop();
      //                     },
      //                     child: Container(
      //                         alignment: Alignment.center,
      //                         width: 110.w,
      //                         height: 40.h,
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(9.r),
      //                           boxShadow: [
      //                             BoxShadow(
      //                               color: const Color(0x3f000000),
      //                               blurRadius: 16.r,
      //                               offset: const Offset(0, 0),
      //                             ),
      //                           ],
      //                           gradient: const LinearGradient(
      //                             colors: [
      //                               Color(0xff4A00E0),
      //                               Color(0xff8E2DE2),
      //                             ],
      //                             begin: Alignment(-1.0, 0),
      //                             end: Alignment(1, 1),
      //                           ),
      //                         ),
      //                         child: Text(
      //                           "Create",
      //                           textAlign: TextAlign.center,
      //                           style: robotoBold.copyWith(
      //                             color: Colors.white,
      //                             fontSize: 18.sp,
      //                           ),
      //                         )),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 15.h,
      //                 )
      //               ],
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   child: Container(
      //     width: 60.w,
      //     height: 60.w,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(9.r),
      //       boxShadow: [
      //         BoxShadow(
      //           color: const Color(0x3f000000),
      //           blurRadius: 16.r,
      //           offset: const Offset(0, 0),
      //         ),
      //       ],
      //       gradient: const LinearGradient(
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //         colors: [Color(0xff4a00e0), Color(0xff8e2de2)],
      //       ),
      //     ),
      //     child: Stack(
      //       children: [
      //         Align(
      //             alignment: Alignment.center,
      //             child: SvgPicture.asset('assets/svg/plus.svg', height: 36.h)),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
