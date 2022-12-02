import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/screen/signup_screen.dart';

import '../storage/storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var storage = SecureStorage();
  var isLogin = false;

  token() async {
    String? token = await storage.read('token');
    print(token);
    if (token != null) {
      isLogin = true;
    }
  }

  @override
  void initState() {
    token();
    Timer(const Duration(seconds: 2), () {
      !isLogin
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashboarScreen()),
              (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Kasir Apps",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w700, color: Colors.red),
          ),
          const Text(
            "Management Produk dan Keuangan",
            style: TextStyle(fontSize: 16, color: Color(0xFF06283D)),
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: MediaQuery.of(context).size.width / 3),
              child: const CircularProgressIndicator())
        ],
      ),
    ));
  }
}
