import 'package:flutter/material.dart';
import 'dart:math';

const kSmallTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'oswald',
);
const kmidTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'oswald',
);
const kLargeTextStyle = TextStyle(
  fontSize: 30,
);

class RadialCircularBarPainter extends CustomPainter {
  final double currentReading;
  final Size canvasSize;
  final Paint backgroundPaint;
  final Paint trackPaint;
  final Paint progressPaint;

  RadialCircularBarPainter({
    required this.currentReading,
    required this.canvasSize,
    required this.backgroundPaint,
    required this.trackPaint,
    required this.progressPaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate dimensions
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2 - trackPaint.strokeWidth;

    // Draw background circle
    canvas.drawCircle(Offset(centerX, centerY), radius, backgroundPaint);

    // Draw track circle
    canvas.drawCircle(Offset(centerX, centerY), radius, trackPaint);

    // Calculate progress angle
    double angle = 2 * pi * (currentReading / 100); // Assuming 0-100 range

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -pi / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint for dynamic updates
  }
}
