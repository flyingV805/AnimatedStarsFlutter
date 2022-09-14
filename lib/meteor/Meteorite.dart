import 'package:flutter/material.dart';

import 'MeteoriteCompleteListener.dart';

class Meteorite {

  Meteorite({
    required this.smallestWidth,
    required this.size,
    required this.listener
  });

  final int smallestWidth;
  final MeteoriteCompleteListener listener;
  final int size;

  int x = 0;
  int y = 0;
  Color color = Colors.white;

}