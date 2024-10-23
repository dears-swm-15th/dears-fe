import 'dart:math';

import 'package:dears/models/radar_key.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

const double _maxScore = 5;

class RadarChart extends StatelessWidget {
  final Map<RadarKey, double> data;

  const RadarChart(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = {
      for (final key in RadarKey.values) key: this.data[key] ?? 0,
    };

    return CustomPaint(
      size: Size.infinite,
      painter: RadarChartPainter(data),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final Map<RadarKey, double> data;

  const RadarChartPainter(this.data) : assert(data.length >= 3);

  @override
  void paint(Canvas canvas, Size size) {
    final n = data.length;

    // small enough to fit in the canvas
    final radius = min(size.width, size.height) / 3;

    final dh = n.isEven ? 1 : cos(pi / n);
    final height = radius * (1 + dh);

    final center = Offset(size.width / 2, (size.height - height) / 2 + radius);

    final offsets = List.generate(n, (index) {
      // start from the top
      final angle = pi / 2 + (2 * pi / n) * index;

      // convert polar to cartesian with flipping the y-axis
      return Offset(cos(angle), sin(-angle));
    });

    final features = data.keys.toList();
    final values = data.values.toList();

    final linePaint = Paint()
      ..color = gray100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // draw spokes
    for (int i = 0; i < n; i++) {
      final vertex = center + offsets[i] * radius;
      canvas.drawLine(center, vertex, linePaint);
    }

    // draw scales
    for (final r in [0.1, 0.4, 0.7, 1.0]) {
      final scale = List.generate(n, (index) {
        return center + offsets[index] * radius * r;
      });
      canvas.drawPath(Path()..addPolygon(scale, true), linePaint);
    }

    // draw a plot area
    final plot = List.generate(n, (index) {
      final r = values[index] / _maxScore;
      return center + offsets[index] * radius * r;
    });
    final plotPaint = Paint()
      ..color = const Color(0xFF0094FF).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawPath(Path()..addPolygon(plot, true), plotPaint);

    // draw labels
    for (int i = 0; i < n; i++) {
      final featurePainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: "${features[i]}",
          style: captionLarge.copyWith(color: gray600),
        ),
      )..layout();

      final valuePainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: "${values[i]}",
          style: titleSmall.copyWith(color: blue500),
        ),
      )..layout();

      final featureSize = featurePainter.size;
      final valueSize = valuePainter.size;
      final labelSize = getLabelSize(featureSize, valueSize);

      final vertex = center + offsets[i] * radius;
      final labelRect = getLabelRect(vertex, offsets[i], labelSize);

      final featureRect = getFeatureRect(labelRect, featureSize);
      featurePainter.paint(canvas, featureRect.topLeft);

      final valueRect = getValueRect(labelRect, valueSize);
      valuePainter.paint(canvas, valueRect.topLeft);
    }
  }

  /// Get the size of the label box that contains the feature and value.
  /// There is a spacing between the feature and value, and there is a padding
  /// around the label box.
  Size getLabelSize(Size featureSize, Size valueSize) {
    final width = max(featureSize.width, valueSize.width);
    final height = featureSize.height + 4 + valueSize.height;
    return Size(width, height) + const Offset(4, 4) * 2;
  }

  /// Get the rectangle that contains the label box, which is centered on the
  /// extension of the direction vector from the origin and positioned exactly
  /// at the end of the spoke.
  Rect getLabelRect(Offset origin, Offset direction, Size labelSize) {
    final Offset(:dx, :dy) = direction;

    final w = labelSize.width / 2;
    final h = labelSize.height / 2;

    final a = dx / dy * h;
    final b = dy / dx * w;

    final k = sqrt(min(w * w, a * a) + min(h * h, b * b));

    return Rect.fromCenter(
      center: origin + direction * k,
      width: labelSize.width,
      height: labelSize.height,
    );
  }

  Rect getFeatureRect(Rect labelRect, Size featureSize) {
    return Rect.fromCenter(
      center: labelRect.topCenter + Offset(0, 4 + featureSize.height / 2),
      width: featureSize.width,
      height: featureSize.height,
    );
  }

  Rect getValueRect(Rect labelRect, Size valueSize) {
    return Rect.fromCenter(
      center: labelRect.bottomCenter - Offset(0, 4 + valueSize.height / 2),
      width: valueSize.width,
      height: valueSize.height,
    );
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) => false;
}
