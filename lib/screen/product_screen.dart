import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
  String _scanBarcode = 'Unknown';
  final player = AudioCache();
  String? choosenKey;
  bool isVisible = false;
  Produk? data = Produk(
      kode: 12345678,
      nama: "- Nama Produk -",
      kategori: "none",
      isSelected: false);
  var kodeCtrl = TextEditingController();
  var namaCtrl = TextEditingController();
  var kategoriCtrl = TextEditingController();
  final List<Produk> _items = [];
  List dropdownitem = [];

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   _items = _generateProduks();
    // });
    setState(() {
      dropdownitem = _generateDropdownKategori(_items);
    });
  }

  // Future<void> startBarcodeScanStream() async {
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //           '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
  //       .listen((barcode) => print(barcode));
  // }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      // player.play('beep.mp3');
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  List _generateDropdownKategori(List<Produk> item) {
    return List.generate(_items.length, (index) {
      return {
        'key': item[index].nama,
      };
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
      appBar: appbarWidget(title: "Produk", context: context),
      drawer: const DrawerMain(),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
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
                                        TotalItem(_items.length),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/icon/profile/toko.png"))),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      child: Text(
                                        data!.nama,
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
                                HargaItem(
                                    title: "Harga Jual Umum", harga: "7.200"),
                                HargaItem(
                                    title: "Harga Jual Member", harga: "0"),
                                HargaItem(
                                    title: "Harga Jual Grosir", harga: "0"),
                                HargaItem(
                                    title: "Harga Jual Online", harga: "0"),
                                HargaItem(
                                    title: "Harga Jual Khusus", harga: "0"),
                                HargaItem(
                                    title: "Harga Jual Spesial", harga: "0"),
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
          );
        },
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
          // dialogProduk(context: context);
          scanBarcodeNormal();
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

  Future<dynamic> dialogProduk({BuildContext? context, Produk? item}) {
    return showDialog(
        context: context!,
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
                          controller: kodeCtrl,
                          item: item?.kode.toString() ?? '',
                        ),
                        InputProduk(
                          title: "Nama Barang",
                          controller: namaCtrl,
                          item: item?.nama ?? '',
                        ),
                        InputProduk(
                          title: "Kategori Barang",
                          controller: kategoriCtrl,
                          item: item?.kategori ?? '',
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10)),
                            onPressed: () {
                              setState(() {
                                _items.add(Produk(
                                    kode: int.parse(kodeCtrl.text),
                                    nama: namaCtrl.text,
                                    kategori: kategoriCtrl.text,
                                    isSelected: false));
                                dropdownitem =
                                    _generateDropdownKategori(_items);
                              });
                              kodeCtrl.clear();
                              namaCtrl.clear();
                              kategoriCtrl.clear();
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
                        onPressed: () {
                          scanBarcodeNormal();
                        },
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
                                image: AssetImage("assets/icon/profile.png")),
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
  }

  Row dropdownHarga() {
    if (dropdownitem.isEmpty) {
      dropdownitem = [
        {"key": "Belum ada Produk"}
      ];
    }
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
                "Nama Produk",
                style: Theme.of(context).textTheme.headline3,
              ),
              isExpanded: true,
              value: choosenKey,
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              borderRadius: BorderRadius.circular(10),
              items: dropdownitem
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

          setState(() {
            data = item;
          });

          Timer(
              const Duration(milliseconds: 200),
              () => setState(() {
                    item.isSelected = false;
                  }));
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
            dialogProduk(context: context, item: item);
          },
        ),
        DataCell(Text(
          item.kategori.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )),
      ],
    );
  }

  @override
  void dispose() {
    kodeCtrl.dispose();
    namaCtrl.dispose();
    kategoriCtrl.dispose();
    super.dispose();
  }
}

class InputProduk extends StatelessWidget {
  String? title;
  TextEditingController? controller;
  String? item;
  InputProduk({Key? key, this.title, this.controller, this.item})
      : super(key: key);

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
        SizedBox(
            width: 300,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(hintText: item ?? ""),
            ))
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
  int items;
  TotalItem(this.items);

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
            items.toString(),
            style: Theme.of(context).textTheme.headline3,
          ),
        )
      ],
    );
  }
}
