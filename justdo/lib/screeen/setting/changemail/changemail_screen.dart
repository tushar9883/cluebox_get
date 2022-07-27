import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/screeen/setting/changemail/changemail_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeMailScreen extends BaseView<ChangeMailController> {
  const ChangeMailScreen({Key? key}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.start,
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
                        "Change Email Id",
                        style: robotoBold.copyWith(
                          color: Colors.black,
                          fontSize: 20.sp,
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
                  height: 30.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Email Id",
                        style: robotoMedium.copyWith(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                      ),
                      TextField(
                        cursorColor: const Color(0xff5566fd),
                        style: robotoRegular.copyWith(
                          color: const Color(0xff111111),
                          fontSize: 14.sp,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 20.h,
                              color: Colors.black,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff5566fd)),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Email Id",
                        style: robotoMedium.copyWith(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                      ),
                      TextField(
                        cursorColor: const Color(0xff5566fd),
                        style: robotoRegular.copyWith(
                          color: const Color(0xff111111),
                          fontSize: 14.sp,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 20.h,
                              color: Colors.black,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff5566fd)),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Container(
                    width: 113.w,
                    height: 49.h,
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
                    child: Center(
                      child: Text(
                        "Save",
                        style: robotoBold.copyWith(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
