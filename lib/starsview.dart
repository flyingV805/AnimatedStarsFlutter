import 'dart:async';
import 'package:flutter/material.dart';
import 'StarsViewPainter.dart';

class StarsView extends StatefulWidget {

  const StarsView({
    super.key,
    this.fps = 60
  });

  final int fps;

  @override
  State<StatefulWidget> createState() => _StarsViewState();

}

class _StarsViewState extends State<StarsView>{

  late Timer timer;

  late StarsViewPainter painter;

  ValueNotifier<bool> shouldRepaint = ValueNotifier<bool>(true);

  bool notifierState = false;

  @override
  void initState() {
    super.initState();

    painter = StarsViewPainter(shouldRepaint);

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