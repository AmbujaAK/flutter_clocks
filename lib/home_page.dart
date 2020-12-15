import 'package:flutter/material.dart';
import 'package:flutter_clocks/clocks/dark_clock.dart';
import 'package:flutter_clocks/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: kBackgroundColor,
        child: DarkClock(),
      ),
    );
  }
}
