import 'package:flutter/material.dart';

Color kRed = const Color(0xffd62828);
Color kWhite = const Color(0xffF3F3F3);

ThemeData theme = ThemeData(
    scaffoldBackgroundColor: kWhite,
    primarySwatch: Colors.red,
    primaryTextTheme: const TextTheme(headline1: TextStyle(fontSize: 24)),
    textTheme: const TextTheme(
        headline2: TextStyle(fontSize: 20, color: Color(0xffd62828))));
