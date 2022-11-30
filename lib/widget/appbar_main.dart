import 'package:flutter/material.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/screen/setting_screen.dart';

PreferredSizeWidget? appbarWidget({String? title, BuildContext? context}) {
  SizeConfig().init(context!);
  return AppBar(
    toolbarHeight: SizeConfig.screenHeight! * 0.12,
    title: Text(
      title ?? "",
      style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 2.5),
    ),
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.help, size: SizeConfig.safeBlockHorizontal! * 3)),
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingScreen()));
          },
          icon: Icon(
            Icons.settings,
            size: SizeConfig.safeBlockHorizontal! * 3,
          ))
    ],
  );
}
