import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: <Color>[
                      Colors.red,
                      Colors.blue,
                    ],
                  )
                )
              ),
              StarsView(
                fps: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
