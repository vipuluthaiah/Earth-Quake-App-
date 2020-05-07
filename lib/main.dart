import 'package:flutter/material.dart';
// import 'home.dart';
import 'network/quakes.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
title: "Earth Quake App",
// home: ShowSimpleMap(),
home: Quakes(),
    );
  }
}