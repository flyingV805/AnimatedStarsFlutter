import 'dart:math';

import 'package:flutter/material.dart';
import 'package:starsview/config/MeteoriteConfig.dart';
import 'package:starsview/meteor/Meteorite.dart';
import 'package:starsview/stars/BaseStar.dart';
import 'package:starsview/stars/StarCompleteListener.dart';
import 'package:starsview/stars/StarConstraints.dart';

import 'config/StarsConfig.dart';
import 'meteor/MeteoriteCompleteListener.dart';
import 'utils/RandomUtils.dart';

class StarsViewPainter extends CustomPainter with StarCompleteListener, MeteoriteCompleteListener {

  StarsViewPainter( ValueNotifier<bool> shouldRepaint, {
    this.starsConfig = const StarsConfig(),
    this.meteoriteConfig = const MeteoriteConfig()
  }): super(repaint: shouldRepaint){
    _repaint = shouldRepaint;
    starConstraints = StarConstraints(
      minStarSize: starsConfig.minStarSize,
      maxStarSize: starsConfig.maxStarSize,
      bigStarThreshold: 259821
    );
  }

  final StarsConfig starsConfig;
  final MeteoriteConfig meteoriteConfig;

  late ValueNotifier<bool> _repaint;
  late StarConstraints starConstraints;

  Random random = Random();

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  bool initialized = false;

  Map<int, BaseStar> starMaps = <int, BaseStar>{};

  Meteorite? meteorite;
  int _meteoriteTick = 0;

  void start(){
    for(int i = 0; i <= starsConfig.starCount; i++){
      final BaseStar _star = _createStar(i);
      starMaps[i] = _star;
    }

    if(meteoriteConfig.enabled){
      meteorite = Meteorite(
          smallestWidth: 2,
          starSize: doubleInRange(random, meteoriteConfig.minMeteoriteSize, meteoriteConfig.maxMeteoriteSize),
          startX: screenWidth,
          startY: doubleInRange(random, 0, screenHeight),
          listener: this,
          random: random,
          color: meteoriteConfig.colors.randomElement(random)
      );
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

    if(meteoriteConfig.enabled){
      _meteoriteTick++;
    }

    if(_repaint.value){
      _updateFrame(canvas, size);
    }else{
      _updateFrame(canvas, size);
    }

  }

  void _updateFrame(Canvas canvas, Size size){
    for(final BaseStar star in starMaps.values.toList()){
      star.draw(canvas);
    }
    meteorite?.updateFrame(size.width, size.height);
    meteorite?.draw(canvas);
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

  BaseStar _createStar(int id){

    starsConfig.colors.randomElement(random);

    return BaseStar(
      id: id,
      random: random,
      color: starsConfig.colors.randomElement(random),
      x: doubleInRange(random, 0.0, screenWidth),
      y: doubleInRange(random, 0.0, screenHeight),
      starListener: this,
      starConstraints: starConstraints
    );
  }

  @override
  void onMeteoriteComplete() {
    meteorite = null;
    _meteoriteTick = 0;

    meteorite = Meteorite(
      smallestWidth: 2, 
      starSize: doubleInRange(random, meteoriteConfig.minMeteoriteSize, meteoriteConfig.maxMeteoriteSize),
      startX: screenWidth, 
      startY: doubleInRange(random, 0, screenHeight), 
      listener: this, 
      random: random, 
      color: meteoriteConfig.colors.randomElement(random)
    );
  }



}