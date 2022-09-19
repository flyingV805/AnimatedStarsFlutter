
import 'package:flutter/material.dart';

class StarsConfig{

  const StarsConfig({
    this.starCount = 75,
    this.minStarSize = .5,
    this.maxStarSize = 3,
    this.colors = const <Color>[Colors.white]
  });

  final int starCount;
  final double minStarSize;
  final double maxStarSize;
  final List<Color> colors;

}