import 'dart:math';

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
            SpeedoMeterWidget(value: _progress, width: 150, height: 150),
          ],
        ),
      ),
    );
  }
}

class SpeedoMeterWidget extends StatelessWidget {
  final double value, width, height;

  const SpeedoMeterWidget(
      {super.key, required this.value, required this.width, required this.height});

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
    final trackPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    canvas.drawArc(rect, pi - 0.5, 0.5 + pi + 0.5, false, trackPaint);
    final valuePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    canvas.drawArc(rect, pi - 0.5, value * (0.5 + pi + 0.5), false, valuePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
