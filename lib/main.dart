import 'package:flutter/material.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/theme/theme.dart';
// import 'package:kasir_online/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasir Online',
      theme: theme,
      home: const DashboarScreen(),
    );
  }
}
