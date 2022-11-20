import 'package:flutter/material.dart';

import '../theme/theme.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      DrawerHeader(
          decoration: BoxDecoration(color: kWhite),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 50,
                foregroundImage: AssetImage("assets/icon/profile.png"),
                backgroundColor: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Text("Admin Garut Shop",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(Icons.shopping_bag),
                              Text("Shop")
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
      const ListTile(
        leading: Icon(
          Icons.dashboard,
          size: 30,
          color: Colors.red,
        ),
        title: Text("Dashboard", style: TextStyle(fontSize: 24)),
      ),
      const Divider(),
    ]));
  }
}
