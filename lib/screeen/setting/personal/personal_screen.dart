import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/res/style.dart';
import 'package:clue_get/screeen/setting/personal/personal_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PersonalScreen extends BaseView<PersonalController> {
  const PersonalScreen({Key? key}) : super(key: key);

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
                            hintText: 'YYYY/MM/DD',
                            hintStyle: robotoRegular.copyWith(
                                color: Colors.black, fontSize: 12.sp),
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 20.h,
                              color: Colors.black,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff5566fd)),
                            )),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);
                            controller.dateinput.text = formattedDate;
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
                  child: DropdownButton(
                    value: controller.dropdownvalue,
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
                    hint: const Text('joh'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: controller.items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      controller.dropdownvalue = newValue!;
                      controller.update();
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {},
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
