import 'package:flutter/material.dart';

class MeteoriteConfig {

  const MeteoriteConfig({
    this.enabled = true,
    this.minMeteoriteSize = .5,
    this.maxMeteoriteSize = 3,
    this.colors = const <Color>[Colors.white],
    this.minMeteoriteSpeed = .4,
    this.maxMeteoriteSpeed = 3
  });

  final bool enabled;
  final double minMeteoriteSize;
  final double maxMeteoriteSize;
  final List<Color> colors;
  final double minMeteoriteSpeed;
  final double maxMeteoriteSpeed;

}