import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/base_view_view_model.dart';
import 'login_binding.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends BaseView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
                )),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(left: 38.w, right: 38.w, top: 30.h),
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
                          "Login",
                          style: poppinsBold.copyWith(
                            color: Colors.black,
                            fontSize: 26.sp,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextField(
                          cursorColor: const Color(0xff5566fd),
                          controller: controller.email,
                          style: poppinsRegular.copyWith(
                            fontSize: 14.sp,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: 'Email Id',
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
                          height: 20.h,
                        ),
                        TextField(
                          controller: controller.password,
                          cursorColor: const Color(0xff5566fd),
                          textInputAction: TextInputAction.go,
                          style: poppinsRegular.copyWith(
                            fontSize: 14.sp,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Password',
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
                          height: 17.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(RouterName.forgotpassword);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: poppinsRegular.copyWith(
                                color: const Color(0xff4a00e0),
                                fontSize: 12.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 42.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouterName.home);
                          },
                          child: Container(
                            height: 50.h,
                            width: 190.w,
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
                                "Login",
                                style: poppinsSBold.copyWith(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouterName.signup);
                          },
                          child: Text(
                            "New User?",
                            style: poppinsRegular.copyWith(
                              color: const Color(0xff4a00e0),
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
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
