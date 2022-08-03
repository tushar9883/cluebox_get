import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/screeen/setting/personal/personal_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../model/country.dart';

class PersonalScreen extends BaseView<PersonalController> {
  const PersonalScreen({Key? key}) : super(key: key);

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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: SvgPicture.asset(
                        'assets/svg/backgr.svg',
                        height: 124.h,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
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
                                  child:
                                      SvgPicture.asset('assets/svg/back.svg')),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 21.w),
                              child: Text(
                                "Personal Information",
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
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 32.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: robotoMedium.copyWith(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  TextField(
                                    cursorColor: const Color(0xff5566fd),
                                    controller: controller.name,
                                    style: robotoRegular.copyWith(
                                      color: const Color(0xff111111),
                                      fontSize: 14.sp,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.edit,
                                        size: 20.h,
                                        color: Colors.black,
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff5566fd)),
                                      ),
                                    ),
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
                                    "Date of Birth",
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
                                    controller: controller.dateinput,
                                    decoration: InputDecoration(
                                      hintText: 'DD-MM-YYYY',
                                      hintStyle: robotoRegular.copyWith(
                                          color: Colors.black, fontSize: 12.sp),
                                      suffixIcon: Icon(
                                        Icons.edit,
                                        size: 20.h,
                                        color: Colors.black,
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff5566fd)),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        print(pickedDate);
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate);
                                        print(formattedDate);
                                        controller.dateinput.text =
                                            formattedDate;
                                        controller.update();
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 32.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: controller.radioSelected,
                                    activeColor: Colors.blue,
                                    onChanged: (value) {
                                      controller.radioSelected = value as int;
                                      controller.radioVal = 'Male';
                                      print(controller.radioVal);
                                      controller.update();
                                    },
                                  ),
                                  Text(
                                    "Male",
                                    style: robotoMedium.copyWith(
                                        fontSize: 14.sp, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: controller.radioSelected,
                                    activeColor: Colors.blue,
                                    onChanged: (value) {
                                      controller.radioSelected = value as int;
                                      controller.radioVal = 'Female';
                                      print(controller.radioVal);
                                      controller.update();
                                    },
                                  ),
                                  Text(
                                    "Female",
                                    style: robotoMedium.copyWith(
                                        fontSize: 14.sp, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 32.w),
                              child: DropdownButton<Country>(
                                value: controller.selectedCountry,
                                elevation: 16,
                                style: robotoRegular.copyWith(
                                  color: const Color(0xff111111),
                                  fontSize: 14.sp,
                                ),
                                isExpanded: true,
                                underline: Container(
                                  height: 1.h,
                                  color: const Color(0xFF999999),
                                ),
                                hint: const Text('Select Country'),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onChanged: (newValue) {
                                  controller.selectedCountry = (newValue!);
                                  controller.update();
                                },
                                items: (controller.jsonCountry ?? [])
                                    .map((Country value) =>
                                        DropdownMenuItem<Country>(
                                            value: value,
                                            child: Text(
                                              '${value.name}',
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            InkWell(
                              onTap: () {
                                controller.savedata();
                              },
                              child: Center(
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
                                      colors: [
                                        Color(0xff4a00e0),
                                        Color(0xff8e2de2)
                                      ],
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
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
