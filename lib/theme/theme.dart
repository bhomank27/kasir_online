import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Color kRed = const Color(0xffd62828);
Color kWhite = const Color(0xffF3F3F3);

ThemeData theme = ThemeData(
    scaffoldBackgroundColor: kWhite,
    primaryColor: Colors.red,
    primarySwatch: Colors.red,
    primaryTextTheme: const TextTheme(headline1: TextStyle(fontSize: 24)),
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 12.sp),
      headline1: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      headline2: TextStyle(fontSize: 15.sp, color: Colors.red),
      headline3: TextStyle(fontSize: 15.sp, color: Colors.black),
    ));
