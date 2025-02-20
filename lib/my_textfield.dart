import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield {
  static Widget textFieldForm(String description, double widthContainer,
      TextEditingController myController,
      {FocusNode? myNode, TextInputType? keyboard}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          SizedBox(
            width: widthContainer,
            child: Text(
              description,
              style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            height: 48.h,
            width: widthContainer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Center(
                child: TextField(
                  focusNode: myNode,
                  controller: myController,
                  decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: '',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 18.sp)),
                  keyboardType: keyboard ?? TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp),
                  onChanged: (text) {
                    // Additional functionality can be added here
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget textFieldCalendar(
      String description,
      double widthContainer,
      TextEditingController myController,
      bool isStartDate,
      VoidCallback onToggle,
      void Function(String) onChange) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
          child: SizedBox(
            width: widthContainer,
            child: Text(
              description,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          height: 46.h,
          width: widthContainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.r)),
            border: Border.all(color: Color(0xFFDAE0E6), width: 2.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: '',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 14.sp)),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                      onChanged: (text) {
                        onChange(text);
                      },
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: onToggle,
                    child: Icon(
                      isStartDate
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 20.w,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget textFieldViewCategory(
      String description,
      double widthContainer,
      String currentText,
      bool isOpenMenuCategory,
      VoidCallback onToggle,
      List<String> categoryMenu,
      void Function(String) onTapMenuElem) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          SizedBox(
            width: widthContainer,
            child: Text(
              description,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            height: isOpenMenuCategory
                ? categoryMenu.isEmpty
                    ? 46.h
                    : null
                : 46.h,
            width: widthContainer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: currentText.isEmpty ? 13.h : 0),
              child: isOpenMenuCategory
                  ? Stack(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: categoryMenu.map((toElement) {
                              return GestureDetector(
                                onTap: () {
                                  onTapMenuElem(toElement);
                                },
                                child: Text(
                                  toElement,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp),
                                ),
                              );
                            }).toList()),
                        Positioned(
                          right: 0.w,
                          top: 0.h,
                          child: GestureDetector(
                              onTap: onToggle,
                              child: Icon(
                                isOpenMenuCategory
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                size: 20.w,
                              )),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Text(
                            currentText,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp),
                          ),
                        ),
                        GestureDetector(
                            onTap: onToggle,
                            child: Icon(
                              isOpenMenuCategory
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              size: 20.w,
                            )),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget descriptionTextFieldForm(
      String description,
      double widthContainer,
      TextEditingController myController,
      FocusNode focus) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
          child: SizedBox(
            width: widthContainer,
            child: Text(
              description,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          height: 108.h,
          width: widthContainer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.r)),
              border: Border.all(color: Color(0xFFDAE0E6), width: 2.w)),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                maxLines: null,
                focusNode: focus,
                controller: myController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: '',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 18.sp)),
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.black,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
                onChanged: (text) {},
              )),
        ),
      ],
    );
  }
}
