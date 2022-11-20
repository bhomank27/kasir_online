import 'package:flutter/material.dart';
import 'package:kasir_online/widget/appbar_main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "profile"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: ListView(children: [
          ListTile(
            leading: Image.asset("assets/icon/profile/toko.png"),
            title: const Text("Nama Usaha"),
            subtitle: const Text("Garut Shop"),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset("assets/icon/profile/lokasi.png"),
            title: const Text("Alamat"),
            subtitle: const Text("Jl. Raya Rancabango"),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset("assets/icon/profile/phone.png"),
            title: const Text("Telepon"),
            subtitle: const Text("031-012345"),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset("assets/icon/profile/kota.png"),
            title: const Text("Kota"),
            subtitle: const Text("Kota Garut"),
          ),
          const Divider(),
          Container(
              margin: EdgeInsets.all(10),
              child: const Text("Logo Struk",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold))),
          Row(
            children: List.generate(
                3,
                (index) => Column(
                      children: [
                        const Text("Logo 1"),
                        Container(
                          height: 150,
                          width: 150,
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                              image: const DecorationImage(
                                  image: AssetImage("assets/icon/logo.png"))),
                        ),
                        Row(
                          children: [
                            RawMaterialButton(
                              onPressed: () {},
                              padding: const EdgeInsets.all(10.0),
                              fillColor: Colors.red,
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              padding: const EdgeInsets.all(10.0),
                              fillColor: Colors.red,
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Icon(Icons.save), Text("Simpan")],
                )),
          )
        ]),
      ),
    );
  }
}
