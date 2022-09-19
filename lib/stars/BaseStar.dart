import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/RandomUtils.dart';
import 'StarCompleteListener.dart';
import 'StarConstraints.dart';

class BaseStar {

  BaseStar({
    required this.id,
    required this.x,
    required this.y,
    required this.starListener,
    required this.starConstraints,
    required this.random,
    required this.color
  }){
    size = starConstraints.getRandomSize();
    multiplierFactor = doubleInRange(random, 0.01, 0.09);
    incrementFactor = doubleInRange(random, 0.1, 0.3);
  }

  final int id;
  final double x;
  final double y;
  final StarCompleteListener starListener;
  final StarConstraints starConstraints;
  final Random random;
  final Color color;

  late double size;

  double alpha = 0.0;
  double multiplierFactor = 0.0;
  double incrementFactor = 0.0;

  final Paint paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..style = PaintingStyle.fill;

  void draw(Canvas canvas){

    if (alpha > 1){
      multiplierFactor *= -1.0;
    }

    alpha += incrementFactor * multiplierFactor;

    if (alpha <= 0.0) {
      starListener.onStarAnimationComplete(id);
      return;
    }

    paint.color = color.withOpacity(alpha.clamp(0, 1)); //Color.fromRGBO(255, 255, 255, alpha.clamp(0, 1));

    canvas.drawCircle(Offset(x, y), size, paint);

  }

}