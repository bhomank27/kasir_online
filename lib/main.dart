import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/screen/sigin_screen.dart';
import 'package:kasir_online/screen/signup_screen.dart';
import 'package:kasir_online/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English, no country code
        Locale('id'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Kasir Online',
      theme: theme,
      initialRoute: "/",
      routes: {
        "/": (context) => const SignUpScreen(),
        "/signIn": (context) => const SignInScreen(),
        "/dashboard": (context) => const DashboarScreen(),
      },
    );
  }
}
