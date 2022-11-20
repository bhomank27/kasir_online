import 'package:flutter/material.dart';

PreferredSizeWidget? appbarWidget() {
  return AppBar(
    elevation: 0,
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
    ],
  );
}
