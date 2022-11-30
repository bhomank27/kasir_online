import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appbarWidget(title: "Pengaturan", context: context),
      drawer: const DrawerMain(),
      body: Container(
        margin: EdgeInsets.all(SizeConfig.screenHeight! * 0.05),
        child: GridView(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: SizeConfig.safeBlockVertical! * 3,
              crossAxisSpacing: SizeConfig.blockSizeHorizontal! * 5,
              mainAxisExtent: SizeConfig.screenHeight! * 0.3),
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
                        content: Text(
                          "Yakin Keluar ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal! * 2),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (route) => false);
                              },
                              child: Text(
                                "Ya",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal! * 1.5),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Tidak",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal! * 1.5),
                              )),
                        ],
                      )),
              child: ButtonSetting(
                title: "Keluar",
                iconData: Icons.logout,
              ),
            ),
          ],
        ),
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
    SizeConfig().init(context);
    return Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData!,
              color: Theme.of(context).primaryColor,
              size: SizeConfig.safeBlockHorizontal! * 4,
            ),
            Text(
              title!,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 2,
                  color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
