import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String mechanism = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mechanism = Hive.box("menu_page_watch").get("Mechanism");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Align(
          child: SizedBox(
            width: 337.w,
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
                      "Settings",
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
                  height: 56.h,
                ),
                Container(
                  width: 360.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "The dial",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        DropMenu(onUpdate: (t0) {
                          Hive.box("menu_page_watch").put("Mechanism", t0);
                          setState(() {});
                          Navigator.pop(context);
                        })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 38.h,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String? encodeQueryParameters(
                            Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }

                        // ···
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'Poyraztemeze@icloud.com',
                          query: encodeQueryParameters(<String, String>{
                            '': '',
                          }),
                        );
                        try {
                          if (await canLaunchUrl(emailLaunchUri)) {
                            await launchUrl(emailLaunchUri);
                          } else {
                            throw Exception("Could not launch $emailLaunchUri");
                          }
                        } catch (e) {
                          log('Error launching email client: $e'); // Log the error
                        }
                      },
                      child: helpContentBtn("Contact Us"),
                    ),
                    GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(
                              'https://docs.google.com/document/d/1K2WoNfItK8NkqCPf7cA1fnEY7KYUKNv8wQcUuTO34Ko/mobilebasic');
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: helpContentBtn("Privacy Policy")),
                    GestureDetector(
                        onTap: () {
                          InAppReview.instance.openStoreListing(
                            appStoreId: '6742192349',
                          );
                        },
                        child: helpContentBtn("Rate Us"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget helpContentBtn(String desctiption) {
    return Padding(
      padding: EdgeInsets.only(bottom: 13.h),
      child: Container(
        width: 360.w,
        height: 52.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                desctiption,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Icon(Icons.arrow_forward_ios, size: 12.w, color: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}

class DropMenu extends StatefulWidget {
  const DropMenu({super.key, required this.onUpdate});
  final void Function(String) onUpdate;

  @override
  // ignore: library_private_types_in_public_api
  _DropMenuState createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu> {
  String? selectedValue; // Переменная для хранения выбранного значения

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Align(
        alignment: Alignment.topRight,
        child: DropdownButton2(
          barrierColor: Colors.black45,
          customButton: SizedBox(
            height: 52.h,
            child: Row(
              children: [
                Text(
                  Hive.box("menu_page_watch").get("Mechanism"),
                  style: TextStyle(
                      fontSize: 17.61.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 15.w,
                )
              ],
            ),
          ),
          items: [
            DropdownMenuItem<String>(
              value: "Electronic",
              child: GestureDetector(
                onTap: () async {
                  widget.onUpdate("Electronic");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Electronic",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: "Mechanical",
              child: GestureDetector(
                onTap: () async {
                  widget.onUpdate("Mechanical");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Mechanical",
                    style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
          value: selectedValue, // Устанавливаем текущее значение
          onChanged: (value) {
            selectedValue = value; // Обновляем значение
          },

          dropdownStyleData: DropdownStyleData(
            maxHeight: 300.h,
            width: 250.w,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(237, 237, 237, 0.9),
            ),
            offset: Offset(0.w, -10),
          ),
          menuItemStyleData: MenuItemStyleData(customHeights: [
            50.h,
            50.h,
          ], padding: EdgeInsets.all(0)),
        ),
      ),
    );
  }
}
