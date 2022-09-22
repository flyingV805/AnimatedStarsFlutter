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
    _size = starConstraints.getRandomSize();
    _multiplierFactor = doubleInRange(random, 0.01, 0.09);
    _incrementFactor = doubleInRange(random, 0.1, 0.3);
  }

  final int id;
  final double x;
  final double y;
  final StarCompleteListener starListener;
  final StarConstraints starConstraints;
  final Random random;
  final Color color;

  late double _size;

  double _alpha = 0.0;
  double _multiplierFactor = 0.0;
  double _incrementFactor = 0.0;

  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..style = PaintingStyle.fill;

  void draw(Canvas canvas){

    if (_alpha > 1){
      _multiplierFactor *= -1.0;
    }

    _alpha += _incrementFactor * _multiplierFactor;

    if (_alpha <= 0.0) {
      starListener.onStarAnimationComplete(id);
      return;
    }

    _paint.color = color.withOpacity(_alpha.clamp(0, 1)); //Color.fromRGBO(255, 255, 255, alpha.clamp(0, 1));

    canvas.drawCircle(Offset(x, y), _size, _paint);

  }

}