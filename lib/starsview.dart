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

  late Timer timer;

  late StarsViewPainter painter;

  ValueNotifier<bool> shouldRepaint = ValueNotifier<bool>(true);

  bool notifierState = false;

  Orientation? lastOrientation;

  @override
  void initState() {
    super.initState();

    painter = StarsViewPainter(
      shouldRepaint,
      starsConfig: widget.starsConfig,
      meteoriteConfig: widget.meteoriteConfig
    );

    timer = Timer.periodic(Duration(milliseconds: 1000~/widget.fps), (Timer timer) {
      setState(() {
        notifierState = !notifierState;
        shouldRepaint.value = notifierState;
        //debugPrint('FRAME TICK');
        //painter.tick();
      });
    });

  }

  @override
  void dispose(){
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    lastOrientation ??= MediaQuery.of(context).orientation;

    if (MediaQuery.of(context).orientation != lastOrientation){
      lastOrientation = MediaQuery.of(context).orientation;
      painter.handleChange();
    }

    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: painter,
          child: Container(),
        )
      ],
    );
  }

}