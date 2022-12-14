import 'package:clue_get/res/style.dart';
import 'package:clue_get/screeen/item/additem/additem_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../base/base_view_view_model.dart';

class AdditemScreen extends BaseView<AddItemController> {
  const AdditemScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
                    "Add Item",
                    style: robotoBold.copyWith(
                      color: Colors.black,
                      fontSize: 22.sp,
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
              height: 13.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 13.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 21.h),
                              child: Image.asset('assets/image/check.png')),
                          Container(
                            alignment: Alignment.center,
                            width: 153.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.black,
                                width: 2.w,
                              ),
                            ),
                            child: Text(
                              "Add Item Image",
                              style: robotoBold.copyWith(
                                color: Colors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16.w),
                          child: LikeButton(
                            size: 30.h,
                            likeBuilder: (isTapped) {
                              return SvgPicture.asset(
                                isTapped
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
                      height: 5.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 38.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item Name",
                            style: robotoBold.copyWith(
                              color: Colors.black,
                              fontSize: 18.sp,
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
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff5566fd)),
                            )),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Text(
                            "Tags",
                            style: robotoBold.copyWith(
                              color: Colors.black,
                              fontSize: 18.sp,
                            ),
                          ),
                          TextFieldTags(
                            textfieldTagsController: controller.tagController,
                            textSeparators: const [' ', ','],
                            letterCase: LetterCase.normal,
                            validator: (String tag) {
                              if (tag == 'php') {
                                return 'No, please just no';
                              } else if (controller.tagController.getTags!
                                  .contains(tag)) {
                                return 'you already entered that';
                              }
                              return null;
                            },
                            inputfieldBuilder: (context, tec, fn, error,
                                onChanged, onSubmitted) {
                              return ((context, sc, tags, onTagDelete) {
                                return TextField(
                                  controller: tec,
                                  cursorColor: const Color(0xff5566fd),
                                  style: robotoRegular.copyWith(
                                    color: const Color(0xff111111),
                                    fontSize: 14.sp,
                                  ),
                                  focusNode: fn,
                                  decoration: InputDecoration(
                                    hintText: controller.tagController.hasTags
                                        ? ''
                                        : "Use comma to separate tags",
                                    errorText: error,
                                    // prefixIconConstraints: BoxConstraints(maxWidth: distanceToField * 0.74),
                                    prefixIcon: tags.isNotEmpty
                                        ? SingleChildScrollView(
                                            controller: sc,
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                children:
                                                    tags.map((String tag) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Color(0xffD3D3D3),
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        '#$tag',
                                                        style: robotoRegular
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        print("$tag selected");
                                                      },
                                                    ),
                                                    SizedBox(width: 4.w),
                                                    InkWell(
                                                      child: const Icon(
                                                        Icons.cancel,
                                                        size: 14.0,
                                                        color:
                                                            Color(0xff111111),
                                                        // color: Color.fromARGB(
                                                        //     255, 233, 233, 233),
                                                      ),
                                                      onTap: () {
                                                        onTagDelete(tag);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList()),
                                          )
                                        : null,
                                  ),
                                  onChanged: onChanged,
                                  onSubmitted: onSubmitted,
                                );
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Box Number/Name",
                                style: robotoBold.copyWith(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // title: Text('Welcome'),
                                        content: Text(
                                          'Where are you putting your items?',
                                          style: robotoRegular.copyWith(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 20.w,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
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
                                  child: Text(
                                    '?',
                                    textAlign: TextAlign.center,
                                    style: robotoBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          DropdownButton(
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
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Location",
                                style: robotoBold.copyWith(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // title: Text('Welcome'),
                                        title: Text(
                                          'Where is the box located?',
                                          style: robotoRegular.copyWith(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 20.w,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
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
                                  child: Text(
                                    '?',
                                    textAlign: TextAlign.center,
                                    style: robotoBold.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          DropdownButton(
                            value: controller.dropdownvaluess,
                            elevation: 16,
                            isExpanded: true,
                            style: robotoRegular.copyWith(
                              color: const Color(0xff111111),
                              fontSize: 14.sp,
                            ),
                            underline: Container(
                              height: 1.h,
                              color: const Color(0xFF999999),
                            ),
                            hint: const Text('joh'),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.itemsss.map((String itemsss) {
                              return DropdownMenuItem(
                                value: itemsss,
                                child: Text(itemsss),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller.dropdownvaluess = newValue!;
                              controller.update();
                            },
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Text(
                            "Quantity",
                            style: robotoBold.copyWith(
                              color: Colors.black,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: TextField(
                                  maxLines: 1,
                                  cursorColor: const Color(0xff5566fd),
                                  style: robotoRegular.copyWith(
                                    color: const Color(0xff111111),
                                    fontSize: 14.sp,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff5566fd)),
                                  )),
                                  controller: controller.counter,
                                  keyboardType: TextInputType.number,
                                  onChanged: (String) {
                                    print(controller.counter.text);
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  int currentValue =
                                      int.parse(controller.counter.text);
                                  currentValue++;
                                  controller.counter.text =
                                      (currentValue).toString();
                                  controller.update();
                                },
                                child: Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Colors.black,
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                              'assets/svg/inc.svg',
                                              height: 15.h))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              InkWell(
                                onTap: () {
                                  int currentValue =
                                      int.parse(controller.counter.text);
                                  print("Setting state");
                                  currentValue--;
                                  controller.counter.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString();
                                  controller.update();
                                },
                                child: Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Colors.black,
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                              'assets/svg/dec.svg',
                                              width: 15.h))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: Container(
                              width: 177.w,
                              height: 48.h,
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
                                  "Add Item",
                                  style: robotoBold.copyWith(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
