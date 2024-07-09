import 'dart:math';

import 'package:flutter/material.dart';

class RadarChart extends StatelessWidget {
  final Map<String, double> data;

  const RadarChart(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: RadarChartPainter(data),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final Map<String, double> data;

  const RadarChartPainter(this.data) : assert(data.length >= 3);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 3;

    final n = data.length;

    final offsets = List.generate(n, (index) {
      final angle = pi / 2 + (2 * pi / n) * index;
      return Offset(cos(angle), sin(-angle));
    });

    final features = data.keys.toList();
    final values = data.values.toList();

    for (int i = 0; i < n; i++) {
      canvas.drawLine(
        center,
        center + offsets[i] * radius,
        Paint()
          ..color = const Color(0xFFD7D9DB)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

      final painter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: [
            TextSpan(
              text: "${features[i]}\n",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: "${values[i]}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      )..layout();

      final Offset(:dx, :dy) = offsets[i];
      final w = painter.width / 2;
      final h = painter.height / 2;
      final a = dx / dy * h;
      final b = dy / dx * w;
      final k = sqrt(min(w * w, a * a) + min(h * h, b * b));
      painter.paint(
        canvas,
        center + offsets[i] * radius - Offset(w, h) + offsets[i] * k * 1.1,
      );
    }

    for (final r in [0.1, 0.4, 0.7, 1.0]) {
      canvas.drawPath(
        Path()
          ..addPolygon(
            offsets.map((e) => center + e * radius * r).toList(),
            true,
          ),
        Paint()
          ..color = const Color(0xFFD7D9DB)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }

    canvas.drawPath(
      Path()
        ..addPolygon(
          List.generate(n, (index) {
            final r = values[index] / 10;
            return center + offsets[index] * radius * r;
          }),
          true,
        ),
      Paint()
        ..color = const Color(0xFF0094FF).withOpacity(0.3)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) => false;
}
