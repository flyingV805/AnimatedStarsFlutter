import 'dart:async';
import 'package:flutter/material.dart';
import 'package:starsview/config/MeteoriteConfig.dart';
import 'package:starsview/config/StarsConfig.dart';
import 'StarsViewPainter.dart';

class StarsView extends StatefulWidget {

  const StarsView({
    super.key,
    this.fps = 60,
    this.starsConfig = const StarsConfig(),
    this.meteoriteConfig = const MeteoriteConfig()
  });

  final int fps;
  final StarsConfig starsConfig;
  final MeteoriteConfig meteoriteConfig;

  @override
  State<StatefulWidget> createState() => _StarsViewState();

}

class _StarsViewState extends State<StarsView>{

  late Timer _timer;

  late StarsViewPainter _painter;

  final ValueNotifier<bool> _shouldRepaint = ValueNotifier<bool>(true);

  bool _notifierState = false;

  Orientation? _lastOrientation;

  @override
  void initState() {
    super.initState();

    _painter = StarsViewPainter(
      _shouldRepaint,
      starsConfig: widget.starsConfig,
      meteoriteConfig: widget.meteoriteConfig
    );

    _timer = Timer.periodic(Duration(milliseconds: 1000~/widget.fps), (Timer timer) {
      setState(() {
        _notifierState = !_notifierState;
        _shouldRepaint.value = _notifierState;
        //debugPrint('FRAME TICK');
        //painter.tick();
      });
    });

  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    _lastOrientation ??= MediaQuery.of(context).orientation;

    if (MediaQuery.of(context).orientation != _lastOrientation){
      _lastOrientation = MediaQuery.of(context).orientation;
      _painter.handleChange();
    }

    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: _painter,
          child: Container(),
        )
      ],
    );
  }

}