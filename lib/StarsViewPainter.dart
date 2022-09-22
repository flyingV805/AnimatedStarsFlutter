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
    _starConstraints = StarConstraints(
      minStarSize: starsConfig.minStarSize,
      maxStarSize: starsConfig.maxStarSize,
      bigStarThreshold: 259821
    );
  }

  final StarsConfig starsConfig;
  final MeteoriteConfig meteoriteConfig;

  late ValueNotifier<bool> _repaint;
  late StarConstraints _starConstraints;

  final Random _random = Random();

  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  bool _initialized = false;

  final Map<int, BaseStar> _starMaps = <int, BaseStar>{};

  Meteorite? _meteorite;
  int _meteoriteTick = 0;
  bool _meteoriteOnScreen = false;

  void handleChange(){
    debugPrint('ORIENTATION CHANGED');
    _initialized = false;
  }

  void start(){
    for(int i = 0; i <= starsConfig.starCount; i++){
      final BaseStar _star = _createStar(i);
      _starMaps[i] = _star;
    }

    if(meteoriteConfig.enabled){
      _createMeteorite();
    }

  }

  @override
  void paint(Canvas canvas, Size size) {
    if(!_initialized){
      _screenWidth = size.width;
      _screenHeight = size.height;
      debugPrint('WIDTH: $_screenWidth HEIGHT: $_screenHeight');
      _initialized = true;
      start();
    }

    if(meteoriteConfig.enabled){
      if(!_meteoriteOnScreen) {
        _meteoriteTick++;
      }
      if(_meteoriteTick > 500){
        _createMeteorite();
      }
    }

    if(_repaint.value){
      _updateFrame(canvas, size);
    }else{
      _updateFrame(canvas, size);
    }

  }

  void _updateFrame(Canvas canvas, Size size){
    for(final BaseStar star in _starMaps.values.toList()){
      star.draw(canvas);
    }
    _meteorite?.updateFrame(size.width, size.height);
    _meteorite?.draw(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void onStarAnimationComplete(int id) {
    _starMaps.remove(id);
    _starMaps[id] = _createStar(id);
  }

  BaseStar _createStar(int id){

    starsConfig.colors.randomElement(_random);

    return BaseStar(
      id: id,
      random: _random,
      color: starsConfig.colors.randomElement(_random),
      x: doubleInRange(_random, 0.0, _screenWidth),
      y: doubleInRange(_random, 0.0, _screenHeight),
      starListener: this,
      starConstraints: _starConstraints
    );
  }

  void _createMeteorite(){
    _meteoriteTick = 0;
    _meteoriteOnScreen = true;
    _meteorite = Meteorite(
        smallestWidth: 2,
        starSize: doubleInRange(_random, meteoriteConfig.minMeteoriteSize, meteoriteConfig.maxMeteoriteSize),
        startX: _screenWidth,
        startY: doubleInRange(_random, 0, _screenHeight),
        listener: this,
        random: _random,
        color: meteoriteConfig.colors.randomElement(_random)
    );
  }

  @override
  void onMeteoriteComplete() {
    _meteorite = null;
    _meteoriteTick = 0;
    _meteoriteOnScreen = false;
  }



}