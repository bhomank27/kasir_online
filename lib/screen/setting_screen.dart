import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "Pengaturan", context: context),
      drawer: const DrawerMain(),
      body: Column(
        children: [
          Row(
            children: [
              ButtonSetting(
                title: "Bahasa",
                iconData: Icons.language,
              ),
              ButtonSetting(
                title: "Tanggal",
                iconData: Icons.calendar_month,
              ),
              ButtonSetting(
                title: "Cetak",
                iconData: Icons.print,
              ),
            ],
          ),
          Row(
            children: [
              ButtonSetting(
                title: "Pemulihan Cadangan",
                iconData: Icons.backup,
              ),
              ButtonSetting(
                title: "Login Pengguna",
                iconData: Icons.login,
              ),
              InkWell(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text("Yakin Keluar ?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (route) => false);
                                },
                                child: Text("Ya")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Tidak")),
                          ],
                        )),
                child: ButtonSetting(
                  title: "Keluar",
                  iconData: Icons.logout,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonSetting extends StatelessWidget {
  String? title;
  IconData? iconData;
  ButtonSetting({this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      width: 400,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData!,
              size: 60,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              title!,
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}
