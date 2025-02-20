import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:watch_app/hive/hive_boxes.dart';
import 'package:watch_app/hive/watch_model.dart';
import 'package:watch_app/menu_page.dart';
import 'package:watch_app/my_textfield.dart';

class RedactCollectionPage extends StatefulWidget {
  const RedactCollectionPage({super.key, required this.index});
  final int index;
  @override
  State<RedactCollectionPage> createState() => _RedactCollectionPageState();
}

class _RedactCollectionPageState extends State<RedactCollectionPage> {
  Uint8List? _image;
  Box<WatchModel> watchBox = Hive.box<WatchModel>(HiveBoxes.watchBox);
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
  }

  TextEditingController brandNameController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController costController = TextEditingController();
  MenuBtnElemt typeOfWatch = MenuBtnElemt(
      title: "Type of watch", elements: ["Electronic", "Mechanical"]);
  MenuBtnElemt mechanism = MenuBtnElemt(
      elements: ["Mechanical", "Automatic", "Quartz"], title: 'Mechanism');
  MenuBtnElemt strapType = MenuBtnElemt(
      elements: ["Leather", "Metal", "Polymer", "Canvas", "Rubber", "Other"],
      title: 'Strap Type');
  MenuBtnElemt glassMaterial = MenuBtnElemt(
      elements: ["Plastic", "Mineral", "Sapphire", "Combined"],
      title: 'Glass material');
  FocusNode node = FocusNode();
  bool checkAddCollection() {
    return _image != null &&
        brandNameController.text.isNotEmpty &&
        serialNumberController.text.isNotEmpty &&
        seriesController.text.isNotEmpty &&
        costController.text.isNotEmpty &&
        typeOfWatch.currentElement.isNotEmpty &&
        mechanism.currentElement.isNotEmpty &&
        strapType.currentElement.isNotEmpty &&
        glassMaterial.currentElement.isNotEmpty;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = watchBox.getAt(widget.index)?.image;
    brandNameController.text = watchBox.getAt(widget.index)?.brandName ?? "";
    serialNumberController.text =
        watchBox.getAt(widget.index)?.serialNumber ?? "";
    seriesController.text = watchBox.getAt(widget.index)?.series ?? "";
    costController.text = watchBox.getAt(widget.index)?.cost ?? "";
    typeOfWatch.currentElement =
        watchBox.getAt(widget.index)?.typeOfWatch ?? "";
    mechanism.currentElement = watchBox.getAt(widget.index)?.mechanism ?? "";
    strapType.currentElement = watchBox.getAt(widget.index)?.strapType ?? "";
    glassMaterial.currentElement =
        watchBox.getAt(widget.index)?.glassMaterial ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 341.w,
            child: KeyboardActions(
              config: KeyboardActionsConfig(nextFocus: false, actions: [
                KeyboardActionsItem(
                  focusNode: node,
                ),
              ]),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFF0000)),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        getLostData().whenComplete(() {
                          setState(() {});
                        });
                      },
                      child: Container(
                        width: 341.w,
                        height: 261.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            border:
                                Border.all(width: 2.w, color: Colors.black)),
                        child: _image != null
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 5.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(_image!),
                                          fit: BoxFit.fill),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : EmptyImage(),
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    MyTextfield.textFieldForm(
                      "Brand name",
                      341.w,
                      brandNameController,
                    ),
                    MyTextfield.textFieldForm(
                      "Serial number",
                      341.w,
                      serialNumberController,
                    ),
                    MyTextfield.textFieldForm(
                      "Series",
                      341.w,
                      seriesController,
                    ),
                    MyTextfield.textFieldForm("Cost", 341.w, costController,
                        myNode: node, keyboard: TextInputType.number),
                    MyTextfield.textFieldViewCategory(
                        typeOfWatch.title,
                        341.w,
                        typeOfWatch.currentElement,
                        typeOfWatch.isOpenMenu,
                        () {
                          typeOfWatch.isOpenMenu = !typeOfWatch.isOpenMenu;
                          setState(() {});
                        },
                        typeOfWatch.elements,
                        (text) {
                          typeOfWatch.currentElement = text;
                          typeOfWatch.isOpenMenu = !typeOfWatch.isOpenMenu;
                          setState(() {});
                        }),
                    MyTextfield.textFieldViewCategory(
                        mechanism.title,
                        341.w,
                        mechanism.currentElement,
                        mechanism.isOpenMenu,
                        () {
                          mechanism.isOpenMenu = !mechanism.isOpenMenu;
                          setState(() {});
                        },
                        mechanism.elements,
                        (text) {
                          mechanism.currentElement = text;
                          mechanism.isOpenMenu = !mechanism.isOpenMenu;
                          setState(() {});
                        }),
                    MyTextfield.textFieldViewCategory(
                        strapType.title,
                        341.w,
                        strapType.currentElement,
                        strapType.isOpenMenu,
                        () {
                          strapType.isOpenMenu = !strapType.isOpenMenu;
                          setState(() {});
                        },
                        strapType.elements,
                        (text) {
                          strapType.currentElement = text;
                          strapType.isOpenMenu = !strapType.isOpenMenu;
                          setState(() {});
                        }),
                    MyTextfield.textFieldViewCategory(
                        glassMaterial.title,
                        341.w,
                        glassMaterial.currentElement,
                        glassMaterial.isOpenMenu,
                        () {
                          glassMaterial.isOpenMenu = !glassMaterial.isOpenMenu;
                          setState(() {});
                        },
                        glassMaterial.elements,
                        (text) {
                          glassMaterial.currentElement = text;
                          glassMaterial.isOpenMenu = !glassMaterial.isOpenMenu;
                          setState(() {});
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: GestureDetector(
                        onTap: () {
                          if (checkAddCollection()) {
                            watchBox.putAt(
                                widget.index,
                                WatchModel(
                                    image: _image!,
                                    brandName: brandNameController.text,
                                    serialNumber: serialNumberController.text,
                                    series: seriesController.text,
                                    cost: costController.text,
                                    typeOfWatch: typeOfWatch.currentElement,
                                    mechanism: mechanism.currentElement,
                                    strapType: strapType.currentElement,
                                    glassMaterial:
                                        glassMaterial.currentElement));
                            Navigator.pop(context);
                          }
                        },
                        child: BtnWidget(
                          width: 341.w,
                          height: 64.h,
                          title: 'Add to Collection',
                          textStyle: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          color: checkAddCollection()
                              ? Colors.black
                              : Colors.black.withValues(alpha: 0.4),
                          shadow: [
                            BoxShadow(
                                offset: Offset(0, 2.h),
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 4.r)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyImage extends StatelessWidget {
  const EmptyImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/default_image.svg",
          width: 80.w,
          height: 80.h,
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          textAlign: TextAlign.center,
          "Add a clock image from \nthe gallery or take a photo",
          style: GoogleFonts.montserrat(
              fontSize: 18.sp, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class MenuBtnElemt {
  String title;
  String currentElement = "";
  bool isOpenMenu = false;
  List<String> elements = [];
  MenuBtnElemt({required this.title, required this.elements});
}
