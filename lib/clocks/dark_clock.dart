import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_clocks/constants.dart';

class DarkClock extends StatefulWidget {
  @override
  _DarkClockState createState() => _DarkClockState();
}

class _DarkClockState extends State<DarkClock> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  // 1 sec == 6 degree

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;

    // center of the clock
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    // brush
    var dialBrush = Paint()..color = kClockDialColor;

    var dialPadBrush = Paint()
      ..color = kClockDialPadColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var dialCenterBrush = Paint()..color = kClockDialPadColor;

    var secHandBrush = Paint()
      ..color = kSecHandColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [kMinHandColor1, kMinHandColor2])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [kHourHandColor1, kHourHandColor2])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    var dashBrush = Paint()
      ..color = kClockDialPadColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    // canvas
    canvas.drawCircle(center, radius - 40, dialBrush);
    canvas.drawCircle(center, radius - 40, dialPadBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, dialCenterBrush);

    var outterClockRadius = radius;
    var innerClockRadius = radius - 14;

    for (var i = 0; i < 360; i += 36) {
      var x1 = centerX + outterClockRadius * cos(i * pi / 180);
      var y1 = centerY + outterClockRadius * sin(i * pi / 180);

      var x2 = centerX + innerClockRadius * cos(i * pi / 180);
      var y2 = centerY + innerClockRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
