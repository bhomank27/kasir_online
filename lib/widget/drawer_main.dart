import 'package:flutter/material.dart';
import 'package:kasir_online/screen/profile_screen.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Admin\nGarut Shop",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(Icons.shopping_bag),
                              Text("Toko")
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
      ListTile(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
            context, "/dashboard", (route) => false),
        leading: Icon(
          Icons.dashboard,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
        title: const Text("Dashboard", style: TextStyle(fontSize: 24)),
      ),
      const Divider(),
    ]));
  }
}
