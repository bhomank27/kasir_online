import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kasir_online/model/product_model.dart';
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
  bool isVisible = false;
  List<Produk> _items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = _generateProduks();
    });
  }

  List<Produk> _generateProduks() {
    return List.generate(3, (int index) {
      return Produk(
        kode: index + 1,
        nama: 'Nama Produk ${index + 1}',
        kategori: "Makanan",
        isSelected: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarWidget(title: "Produk"),
      drawer: const DrawerMain(),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                // data table
                Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    dropdownHarga(),
                                    const TotalItem()
                                  ],
                                )
                              ],
                            ),
                          ),

                          //data table produk
                          dataTableTransaksi(context),
                        ],
                      ),
                    )),

                //preview item
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      buttonAddProduct(context),
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
                            HargaItem(
                                title: "Harga Jual Lain-lain", harga: "0"),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buttonAddProduct(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 20)),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(100),
                    content: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InputProduk(
                                title: "Kode Barang",
                              ),
                              InputProduk(
                                title: "Nama Barang",
                              ),
                              InputProduk(
                                title: "Kategori Barang",
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 10)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.save),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Simpan ")
                                    ],
                                  ))
                            ],
                          ),
                          IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.document_scanner_outlined,
                                color: Colors.red,
                                size: 50,
                              )),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/profile.png")),
                                  border: Border.all()),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10)),
                                onPressed: () {},
                                child: Row(
                                  children: const [
                                    Icon(Icons.cloud_upload_rounded),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Upload Gambar ")
                                  ],
                                ))
                          ])
                        ],
                      ),
                    ),
                  ));
        },
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

  SizedBox dataTableTransaksi(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.4,
      child: SingleChildScrollView(
        child: DataTable(
          showCheckboxColumn: false,
          headingTextStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          headingRowColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) => Theme.of(context).primaryColor),
          decoration: const BoxDecoration(color: Colors.white),
          columns: _createColumns(),
          rows: _items.map((item) => _createRow(item)).toList(),
        ),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('Kode'),
        numeric: true,
      ),
      const DataColumn(
        label: Text('Nama Barang'),
        numeric: false,
        tooltip: 'Name of the item',
      ),
      const DataColumn(
        label: Text('Kategori'),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
    ];
  }

  DataRow _createRow(Produk item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.kode),
      selected: item.isSelected,
      onSelectChanged: (bool? isSelected) {
        if (isSelected != null) {
          item.isSelected = isSelected;

          setState(() {});
        }
      },
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
          states.contains(MaterialState.selected)
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Colors.white),
      cells: [
        DataCell(
          Text(
            item.kode.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        DataCell(
          Text(
            item.nama,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            print('onTap');
          },
        ),
        DataCell(Text(
          item.kategori.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )),
      ],
    );
  }
}

class InputProduk extends StatelessWidget {
  String? title;
  TextEditingController? controller;
  InputProduk({
    Key? key,
    this.title,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            title!,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(width: 300, child: TextFormField())
      ],
    );
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
