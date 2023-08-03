import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Progress: ${_progress.toStringAsFixed(2)}"),
            LinearProgressIndicator(value: _progress),
            Slider(
              value: _progress,
              onChanged: (v) => setState(() {
                _progress = v;
              }),
            ),
            SpeedoMeterWidget(value: _progress, width: 250, height: 250),
          ],
        ),
      ),
    );
  }
}

class SpeedoMeterWidget extends StatelessWidget {
  final double value, width, height;

  const SpeedoMeterWidget(
      {super.key,
      required this.value,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: MyPainter(value),
        child: Center(
            child: Text(
          (value * 100).toStringAsFixed(0),
          style: const TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double value;

  const MyPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    /// TRACK
    final trackPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    canvas.drawArc(rect, pi, pi, false, trackPaint);

    /// LINE 1
    final linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (double i = 0; i <= 1; i += 0.1) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(i * pi);
      canvas.translate(size.width / -2, size.height / -2);
      final lineStart = Offset(-15, size.height / 2);
      canvas.drawLine(lineStart, Offset(20, lineStart.dy), linePaint);
      canvas.restore();
    }

    /// LINE 1
    final linePaint2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double i = 0; i <= 1; i += 0.02) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(i * pi);
      canvas.translate(size.width / -2, size.height / -2);
      final lineStart = Offset(-10, size.height / 2);
      canvas.drawLine(lineStart, Offset(10, lineStart.dy), linePaint2);
      canvas.restore();
    }

    /// VALUE
    final valuePaint = Paint()
      ..color = Colors.yellow.withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    canvas.drawArc(rect, pi, value * pi, false, valuePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
