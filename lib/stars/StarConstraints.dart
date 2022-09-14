import 'dart:math';

import '../utils/RandomUtils.dart';


class StarConstraints {

  StarConstraints({
    required this.minStarSize,
    required this.maxStarSize,
    required this.bigStarThreshold
  });

  final double minStarSize;
  final double maxStarSize;
  final int bigStarThreshold;
  late final double maxRandom = maxStarSize - minStarSize;

  double getRandomSize(){
    return doubleInRange(Random.secure(), 1, maxRandom);
  }

}