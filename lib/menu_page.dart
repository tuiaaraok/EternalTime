import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:watch_app/collection_page.dart';
import 'package:watch_app/create_collection_page.dart';
import 'package:watch_app/settings_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late DateTime _currentTime;
  bool watchElect = true;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    if (Hive.box("menu_page_watch").isEmpty) {
      Hive.box("menu_page_watch").put("Mechanism", "Electronic");
    }
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hive.box("menu_page_watch").get("Mechanism") == "Electronic"
                ? ElectWatchWidget(currentTime: _currentTime)
                : MechWatchWidget(currentTime: _currentTime),
            SizedBox(
              height: 69.h,
            ),
            SizedBox(
              width: 308.w,
              height: 331.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const CollectionPage(),
                        ),
                      );
                    },
                    child: BtnWidget(
                      width: 308,
                      height: 98.h,
                      title: 'My collection',
                      textStyle: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const CreateCollectionPage(),
                        ),
                      );
                    },
                    child: BtnWidget(
                      width: 308,
                      height: 98.h,
                      title: 'Add to Collection',
                      textStyle: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const SettingsPage(),
                        ),
                      );
                    },
                    child: BtnWidget(
                      width: 308,
                      height: 98.h,
                      title: 'Settings',
                      textStyle: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

class ElectWatchWidget extends StatelessWidget {
  const ElectWatchWidget({
    super.key,
    required DateTime currentTime,
  }) : _currentTime = currentTime;

  final DateTime _currentTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 308.w,
      height: 308.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 138.w,
            height: 115.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                intl.DateFormat("HH").format(_currentTime),
                style:
                    TextStyle(fontSize: 34.38.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Text(
            intl.DateFormat(":").format(_currentTime),
            style: TextStyle(fontSize: 34.38.sp, fontWeight: FontWeight.w400),
          ),
          Container(
            width: 138.w,
            height: 115.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                intl.DateFormat("mm").format(_currentTime),
                style:
                    TextStyle(fontSize: 34.38.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MechWatchWidget extends StatelessWidget {
  const MechWatchWidget({
    super.key,
    required DateTime currentTime,
  }) : _currentTime = currentTime;

  final DateTime _currentTime;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 160.r,
      child: CustomPaint(
        painter: MechWatchPainter(
            128.r, TextStyle(color: Colors.black, fontSize: 24.sp),
            currentTime: _currentTime),
      ),
    );
  }
}

// ignore: must_be_immutable
class BtnWidget extends StatelessWidget {
  BtnWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.title,
      required this.textStyle,
      this.color = Colors.black,
      this.shadow});
  final double width;
  final double height;
  final String title;
  final TextStyle textStyle;
  Color color;
  List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          boxShadow: shadow),
      child: Center(
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}

class MechWatchPainter extends CustomPainter {
  MechWatchPainter(this.radius, this.textStyle,
      {this.initialAngle = 0, required this.currentTime});

  final double radius;
  final TextStyle textStyle;
  final double initialAngle;
  final DateTime currentTime;
  final double offset = 0; // смещение часов вниз

  final List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2 + offset);

    final center = Offset.zero;
    //  draw hour hand
    final hour = currentTime.hour;
    final minute = currentTime.minute;
    final second = currentTime.second;

    final hourAngle = 2 * pi * (((hour % 12) + minute / 60) / 12);
    final hourHandLength = radius * 0.6;
    final hourHandPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final hourHandEndPoint = Offset(hourHandLength * cos(hourAngle - pi / 2),
        hourHandLength * sin(hourAngle - pi / 2));
    canvas.drawLine(center, hourHandEndPoint, hourHandPaint);

    // Draw minute hand
    final minuteAngle = 2 * pi * ((minute + second / 60) / 60);
    final minuteHandLength = radius * 0.8;
    final minuteHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final minuteHandEndPoint = Offset(
        minuteHandLength * cos(minuteAngle - pi / 2),
        minuteHandLength * sin(minuteAngle - pi / 2));
    canvas.drawLine(center, minuteHandEndPoint, minuteHandPaint);
    //  draw second hand

    final secondAngle = 2 * pi * (second / 60);
    final secondHandLength = radius * 0.9;
    final secondHandPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final secondHandEndPoint = Offset(
        secondHandLength * cos(secondAngle - pi / 2),
        secondHandLength * sin(secondAngle - pi / 2));
    canvas.drawLine(center, secondHandEndPoint, secondHandPaint);

    final numberAngle = 2 * pi / 12;
    for (int i = 0; i < numbers.length; i++) {
      _drawNumber(canvas, numbers[i], numberAngle * (i + 1), (i + 1));
    }
  }

  void _drawNumber(Canvas canvas, String number, double angle, int index) {
    _textPainter.text = TextSpan(text: number, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    final x = radius * cos(angle - pi / 2);
    final y = radius * sin(angle - pi / 2);

    final currentHour = currentTime.hour % 12;
    final hourIndex = currentHour == 0 ? 12 : currentHour;
    final isCurrentHour = hourIndex == index;

    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);
    if (isCurrentHour) {
      final circlePaint = Paint()
        ..color = Color(0xFFE6E1F3)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset.zero, _textPainter.height / 1, circlePaint);
    }

    _textPainter.paint(
        canvas, Offset(-_textPainter.width / 2, -_textPainter.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
