import 'package:clue_get/res/gradient.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/setting/settingpage/setting_binding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../base/base_view_view_model.dart';

class SettingScreen extends BaseView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);

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
                        "Settings",
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
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 21.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xfff5f5f5),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouterName.personal);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.w, right: 16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/profile.svg',
                                        width: 16.w,
                                        // height: 20.h,
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      ),
                                      Text(
                                        "Personal Information",
                                        style: robotoMedium.copyWith(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/next.svg',
                                    height: 14.h,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.h,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      /// TODO Change Mail
                      // InkWell(
                      //   onTap: () {
                      //     //Get.toNamed(RouterName.changemail);
                      //   },
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 15.h,
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 13.w, right: 16.w),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 SvgPicture.asset(
                      //                   'assets/svg/mail.svg',
                      //                   // width: 18.w,
                      //                   // height: 20.h,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 17.w,
                      //                 ),
                      //                 Text(
                      //                   "Change Email Id",
                      //                   style: robotoMedium.copyWith(
                      //                     color: Colors.black,
                      //                     fontSize: 16.sp,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             SvgPicture.asset(
                      //               'assets/svg/next.svg',
                      //               height: 14.h,
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 15.h,
                      //       ),
                      //       Container(
                      //           width: MediaQuery.of(context).size.width,
                      //           height: 1.h,
                      //           color: Colors.white),
                      //     ],
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouterName.changepass);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16.w, left: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/pass.svg',
                                        width: 22.w,
                                        // height: 20.h,
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      ),
                                      Text(
                                        "Change Password",
                                        style: robotoMedium.copyWith(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/next.svg',
                                    height: 14.h,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1.h,
                                color: Colors.white),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16.w, left: 12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/image/about.png',
                                        width: 21.w,
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      ),
                                      Text(
                                        "About Us",
                                        style: robotoMedium.copyWith(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/next.svg',
                                    height: 14.h,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1.h,
                                color: Colors.white),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16.w, left: 12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/privacy.svg',
                                        width: 21.w,
                                        // height: 20.h,
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      ),
                                      Text(
                                        "Privacy Policy",
                                        style: robotoMedium.copyWith(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/next.svg',
                                    height: 14.h,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1.h,
                                color: Colors.white),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16.w, left: 12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/term.svg',
                                        width: 21.w,
                                        // height: 20.h,
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      ),
                                      Text(
                                        "Terms of Use",
                                        style: robotoMedium.copyWith(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/next.svg',
                                    height: 14.h,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 21.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xfff5f5f5),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          controller.showLoadingDialog();
                          await FirebaseAuth.instance.signOut();
                          await controller.storage.deleteAll();
                          print("firebase logout");
                          controller.update();
                          controller.hideDialog();

                          await Get.offAllNamed(RouterName.login);
                          // await Get.offAllNamed(RouterName.login); // badha page ne badh krva
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16.w, left: 12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/logout.svg',
                                        width: 21.w,
                                        // height: 20.h,
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      ),
                                      Text(
                                        "Log Out",
                                        style: robotoMedium.copyWith(
                                          color: const Color(0xffFF3C3C),
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/next.svg',
                                    height: 14.h,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "App Version 0.0.1",
                          style: robotoMedium.copyWith(
                            color: Color(0xff7d7d7d),
                            fontSize: 10.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
