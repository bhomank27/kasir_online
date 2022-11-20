import 'package:flutter/material.dart';

PreferredSizeWidget? appbarWidget({String? title}) {
  return AppBar(
    title: Text(title ?? ""),
    elevation: 0,
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
    ],
  );
}
