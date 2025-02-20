import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:watch_app/hive/hive_boxes.dart';
import 'package:watch_app/hive/watch_model.dart';
import 'package:watch_app/redact_collection_page.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<WatchModel>(HiveBoxes.watchBox).listenable(),
          builder: (context, Box<WatchModel> box, _) {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 358.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 32.w,
                              ),
                            ),
                            Text(
                              "My collection",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 26.sp,
                              ),
                            ),
                            SizedBox(
                              width: 32.w,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 37.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: [
                              for (int i = 0; i < box.values.length; i++)
                                SizedBox(
                                  width: 174.w,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.h, right: 5.w),
                                        child: Container(
                                          width: 170.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 2.w,
                                                  color: Colors.black)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.5.w,
                                                    right: 2.5.w,
                                                    top: 2.5.h),
                                                child: Container(
                                                  height: 124.02.h,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: MemoryImage(
                                                          box.getAt(i)!.image,
                                                        ),
                                                        fit: BoxFit.fill),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.r)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 4.48.h,
                                                  bottom: 3.h,
                                                  left: 2.5.w,
                                                  right: 2.5.w,
                                                ),
                                                child: SizedBox(
                                                  width: 165.34.w,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                              "${box.getAt(i)!.brandName} ",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black),
                                                          children: [
                                                        TextSpan(
                                                            text: box
                                                                .getAt(i)!
                                                                .serialNumber,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.sp,
                                                            ))
                                                      ])),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        RedactCollectionPage(
                                                  index: i,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 26.w,
                                            height: 26.h,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Icon(
                                                Icons.edit_outlined,
                                                size: 20.w,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
