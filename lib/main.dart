import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kasir_online/provider/produk_provider.dart';
import 'package:kasir_online/provider/transaksi_provider.dart';
import 'package:kasir_online/provider/user_provider.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/screen/sigin_screen.dart';
import 'package:kasir_online/screen/splashscreen.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => ProdukProvider()),
            ChangeNotifierProvider(create: (_) => TransaksiProvider()),
          ],
          child: const MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          MaterialApp(
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
          "/": (context) => const SplashScreen(),
          "/signIn": (context) => const SignInScreen(),
          "/dashboard": (context) => const DashboarScreen(),
        },
      ),
    );
  }
}
