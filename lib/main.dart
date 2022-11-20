import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('id'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Kasir Online',
      theme: theme,
      home: const DashboarScreen(),
    );
  }
}
