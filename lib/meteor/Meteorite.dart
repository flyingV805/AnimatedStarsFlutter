import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../utils/RandomUtils.dart';
import 'MeteoriteCompleteListener.dart';

class Meteorite {

  Meteorite({
    required this.smallestWidth,
    required this.starSize,
    required this.listener,
    required this.random,
    required double startX,
    required double startY,
  }){
    factor = starSize * (doubleInRange(random, 0.01, 2) * 1.9);
    x = startX;
    y = startY;
    trailLength = doubleInRange(random, 20, 180);
    debugPrint('METEORITE FACTOR: $factor');
  }

  final Random random;
  final int smallestWidth;
  final MeteoriteCompleteListener listener;
  final double starSize;

  double x = 0;
  double y = 0;
  Color color = Colors.white;

  late double trailLength;
  late double factor;

  bool finished = false;

  void updateFrame(double viewWidth, double viewHeight){

    if(finished){
      return;
    }

    // go left
    x -= factor;

    // go down
    y += factor;

    trailPaint.shader = ui.Gradient.linear(
      Offset(x, y),
      Offset(x + trailLength, y - trailLength),
      <Color>[color, Colors.white.withOpacity(0.0)]
    );

    if (x < (viewWidth * -0.5)) {
      listener.onMeteoriteComplete();
      finished = true;
    }

  }

  final Paint trailPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = const Color.fromRGBO(255, 255, 255, 1)
    ..style = PaintingStyle.fill;

  final Paint paint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = const Color.fromRGBO(255, 255, 255, 1)
    ..style = PaintingStyle.fill;


  void draw(Canvas canvas){

    canvas.drawCircle(Offset(x, y), starSize, paint);

    canvas.drawLine(
      Offset(x, y),
      Offset(x + trailLength, y - trailLength),
      trailPaint
    );

  }

}