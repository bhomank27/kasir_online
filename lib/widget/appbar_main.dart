import 'package:flutter/material.dart';
import 'package:kasir_online/screen/setting_screen.dart';

PreferredSizeWidget? appbarWidget({String? title, BuildContext? context}) {
  return AppBar(
    toolbarHeight: 70,
    title: Text(
      title ?? "",
      style: TextStyle(fontSize: 20),
    ),
    elevation: 0,
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
      IconButton(
          onPressed: () {
            Navigator.push(context!,
                MaterialPageRoute(builder: (context) => const SettingScreen()));
          },
          icon: const Icon(Icons.settings))
    ],
  );
}
