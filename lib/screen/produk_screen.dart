import 'package:flutter/material.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';

class ProdukScreen extends StatefulWidget {
  const ProdukScreen({Key? key}) : super(key: key);

  @override
  State<ProdukScreen> createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  String? choosenKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "Produk"),
      drawer: const DrawerMain(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            // data table
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [dropdownHarga(), const TotalItem()],
                          )
                        ],
                      ),
                    ),
                  ],
                )),

            //preview item
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const ButtonProduct(),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.red,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/profile/toko.png"))),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Text(
                                "Abc Kecap Sedap",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Column(
                      children: [
                        HargaItem(title: "Harga Jual Umum", harga: "7.200"),
                        HargaItem(title: "Harga Jual Member", harga: "0"),
                        HargaItem(title: "Harga Jual Grosir", harga: "0"),
                        HargaItem(title: "Harga Jual Online", harga: "0"),
                        HargaItem(title: "Harga Jual Khusus", harga: "0"),
                        HargaItem(title: "Harga Jual Spesial", harga: "0"),
                        HargaItem(title: "Harga Jual Lain-lain", harga: "0"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row dropdownHarga() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Kata Kunci : ", style: Theme.of(context).textTheme.headline3),
        Container(
          width: 250,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 2)),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                "Nama Barang",
                style: Theme.of(context).textTheme.headline3,
              ),
              isExpanded: true,
              value: choosenKey,
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              borderRadius: BorderRadius.circular(10),
              items: [
                {"key": "ABC SUSU"},
                {"key": "ABC KOPI SUSU"}
              ]
                  .map<DropdownMenuItem<String>>((item) =>
                      DropdownMenuItem<String>(
                          value: item.toString(),
                          child: Text("${item['key']}",
                              style: Theme.of(context).textTheme.headline3)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  choosenKey = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonProduct extends StatelessWidget {
  const ButtonProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 20)),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              "Tambah Produk",
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ));
  }
}

class HargaItem extends StatelessWidget {
  String? title;
  String? harga;
  HargaItem({Key? key, this.title, this.harga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title!,
          style: Theme.of(context).textTheme.headline3,
        )),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 2)),
            child: Text(
              harga!,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        )
      ],
    );
  }
}

class TotalItem extends StatelessWidget {
  const TotalItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Total Item : ",
          style: Theme.of(context).textTheme.headline3,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey, width: 2)),
          child: Text(
            "2440",
            style: Theme.of(context).textTheme.headline3,
          ),
        )
      ],
    );
  }
}
