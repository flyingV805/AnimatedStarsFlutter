import 'dart:math';

import 'package:flutter/material.dart';
import 'package:starsview/stars/BaseStar.dart';
import 'package:starsview/stars/StarCompleteListener.dart';
import 'package:starsview/stars/StarConstraints.dart';

import 'meteor/MeteoriteCompleteListener.dart';
import 'utils/RandomUtils.dart';

class StarsViewPainter extends CustomPainter with StarCompleteListener, MeteoriteCompleteListener {

  StarsViewPainter(ValueNotifier<bool> shouldRepaint): super(repaint: shouldRepaint){
    _repaint = shouldRepaint;
  }

  late ValueNotifier<bool> _repaint;

  final int starCount = 75;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  StarConstraints starConstraints = StarConstraints(minStarSize: 0.5, maxStarSize: 3, bigStarThreshold: 259821);
  bool initialized = false;

  Map<int, BaseStar> starMaps = <int, BaseStar>{};

  void start(){
    for(int i = 0; i <= starCount; i++){
      final BaseStar _star = _createStar(i);
      starMaps[i] = _star;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if(!initialized){
      screenWidth = size.width;
      screenHeight = size.height;
      debugPrint('WIDTH: $screenWidth HEIGHT: $screenHeight');
      initialized = true;
      start();
    }

    if(_repaint.value){
      for(final BaseStar star in starMaps.values.toList()){
        star.draw(canvas);
      }
    }else{
      for(final BaseStar star in starMaps.values.toList()){
        star.draw(canvas);
      }
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void onStarAnimationComplete(int id) {
    starMaps.remove(id);
    starMaps[id] = _createStar(id);
  }

  Random random = Random(2);

  BaseStar _createStar(int id){
    return BaseStar(
      id: id,
      random: random,
      x: doubleInRange(random, 0.0, screenWidth),
      y: doubleInRange(random, 0.0, screenHeight),
      starListener: this,
      starConstraints: starConstraints
    );
  }

  @override
  void onMeteoriteComplete() {

  }



}