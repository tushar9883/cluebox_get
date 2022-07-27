import 'package:clue_get/auth/forgot/forgot_binding.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../base/base_view_view_model.dart';

class ForgotScreen extends BaseView<ForgotController> {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.h, left: 38.w),
              child: SvgPicture.asset(
                'assets/svg/clue.svg',
                height: 38.h,
                width: 195.w,
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 50.h),
                  child: SvgPicture.asset(
                    'assets/svg/cir1.svg',
                    height: 300.h,
                  ),
                )),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 40.h),
                  child: SvgPicture.asset(
                    'assets/svg/cir2.svg',
                    height: 300.h,
                  ),
                  // child: Image.asset('assets/image/2cir.png', height: 300.h),
                )),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(left: 38.w, right: 38.w, top: 30.h),
                // margin: EdgeInsets.symmetric(horizontal: 38.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x59000000),
                      blurRadius: 16.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Forgot\nPassword?",
                          textAlign: TextAlign.center,
                          style: poppinsBold.copyWith(
                            color: Colors.black,
                            fontSize: 26.sp,
                            // fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextField(
                          cursorColor: const Color(0xff5566fd),
                          controller: controller.email,
                          textInputAction: TextInputAction.go,
                          style: poppinsRegular.copyWith(
                            fontSize: 14.sp,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Registered Email Id',
                              hintStyle: poppinsRegular.copyWith(
                                color: const Color(0xff111111),
                                fontSize: 12.sp,
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff5566fd)),
                              )),
                        ),
                        SizedBox(
                          height: 42.h,
                        ),
                        InkWell(
                          onTap: () {
                            controller.forgot();
                          },
                          child: Container(
                            height: 50.h,
                            width: 277.w,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(-1.1, 2.349),
                                end: Alignment(1.151, -0.633),
                                colors: [Color(0xff4a00e0), Color(0xff8e2de2)],
                                stops: [0.0, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Send Magical Link",
                                style: poppinsSBold.copyWith(
                                  color: Colors.white,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouterName.login);
                              },
                              child: Text(
                                "Login",
                                style: poppinsRegular.copyWith(
                                  color: const Color(0xff4a00e0),
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouterName.signup);
                              },
                              child: Text(
                                "Signup",
                                style: poppinsRegular.copyWith(
                                  color: const Color(0xff4a00e0),
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
