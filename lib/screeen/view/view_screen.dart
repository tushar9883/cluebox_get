import 'package:clue_get/screeen/view/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../base/base_view_view_model.dart';

class HomeScreen extends BaseView<ViewController> {
  const HomeScreen({Key? key}) : super(key: key);

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
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 21.w, right: 21.w),
                  width: double.infinity,
                  height: 194.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Image.asset('assets/image/default.png',
                      height: 65.h, width: 74.w, fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 18.h,
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
