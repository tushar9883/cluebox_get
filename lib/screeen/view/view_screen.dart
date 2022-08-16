import 'package:clue_get/screeen/view/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import '../../base/base_view_view_model.dart';
import '../../res/style.dart';
import '../../router/router_name.dart';

class ViewScreen extends BaseView<ViewController> {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 21.w),
                        child: SvgPicture.asset('assets/svg/back.svg'),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/layout.svg',
                      height: 70.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        controller.imgUrl != null
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 21.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: Image.network(
                                        controller.imgUrl.toString(),
                                        height: 194.h,
                                        width: 372.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 21.h),
                                    child:
                                        Image.asset('assets/image/check.png'),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 153.w,
                                      height: 38.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
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
                          height: 18.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 21.w),
                                child: Text(
                                  "${controller.itemModel?.itemName}",
                                  // "Cold Medicine",
                                  style: robotoBold.copyWith(
                                      color: Colors.black,
                                      fontSize: 22.sp,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 21.w),
                              child: LikeButton(
                                size: 30.h,
                                likeBuilder: (e) {
                                  return SvgPicture.asset(
                                    controller.itemModel!.favorite!
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
                          height: 20.h,
                        ),
                        controller.tagdata != null &&
                                controller.tagdata.isNotEmpty == true
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 36.h,
                                    child: ListView.builder(
                                      shrinkWrap: false,
                                      padding: EdgeInsets.only(left: 12.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          (controller.tagdata.length) > 10
                                              ? 10
                                              : controller.tagdata.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print("101010101010");
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.r),
                                              color: const Color(0xff929292),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "#${controller.tagdata[index]?.name}",
                                                textAlign: TextAlign.center,
                                                style: robotoBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 13.sp,
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
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/box_1.svg',
                              color: const Color(0xff4A00E0),
                              height: 12.h,
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "BOX NUMBER/NAME",
                              style: robotoMedium.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "${controller.itemModel?.boxName}",
                          style: robotoBold.copyWith(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/loc.svg',
                              color: const Color(0xff4A00E0),
                              height: 14.h,
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Location",
                              style: robotoMedium.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "${controller.itemModel?.locationName}",
                          // "Bedroom",
                          style: robotoBold.copyWith(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouterName.edititem,
                                arguments: controller.itemModel?.toJson());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 140.w,
                            height: 50.h,
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
                              "Edit Item",
                              textAlign: TextAlign.center,
                              style: robotoBold.copyWith(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Item Added on: ${controller.outputDate}",
                          style: robotoMedium.copyWith(
                            color: const Color(0xff6a6a6a),
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
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
    );
  }
}
