import 'package:flutter/material.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/screen/profile_screen.dart';

import '../theme/theme.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
        width: SizeConfig.screenWidth! * 0.35,
        child: Column(children: [
          DrawerHeader(
              decoration: BoxDecoration(color: kWhite),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: SizeConfig.safeBlockHorizontal! * 5,
                    foregroundImage: AssetImage("assets/icon/profile.png"),
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Garut Shop",
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal! * 2.5,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.blockSizeVertical! * 1,
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal! * 2)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  size: SizeConfig.safeBlockVertical! * 5,
                                ),
                                Text("Toko",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                1.5,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ))
                      ],
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
            title: Text("Dashboard",
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 2,
                )),
          ),
          const Divider(),
        ]));
  }
}
