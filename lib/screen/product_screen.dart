import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/model/product_model.dart';
import 'package:kasir_online/provider/produk_provider.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';
import 'package:provider/provider.dart';

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
      kodeProduk: "12345678",
      namaProduk: "- Nama Produk -",
      typeProduk: "none",
      isSelected: false);
  var kodeCtrl = TextEditingController();
  var namaCtrl = TextEditingController();
  var kategoriCtrl = TextEditingController();
  var hargaUmumCtrl = TextEditingController();
  var hargaGrosirCtrl = TextEditingController();
  List<Produk> _items = [];
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
        'key': item[index].namaProduk,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    var produkProvider = Provider.of<ProdukProvider>(context);
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarWidget(title: "Produk", context: context),
      drawer: const DrawerMain(),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 1.5),
                child: Row(
                  children: [
                    // data table
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal! * 1),
                          padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal! * 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal! * 1),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom:
                                        SizeConfig.blockSizeHorizontal! * 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child:
                                            dropdownkatakunci(produkProvider)),
                                    Expanded(child: totalItem(produkProvider)),
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
                                      height:
                                          SizeConfig.blockSizeHorizontal! * 8,
                                      width:
                                          SizeConfig.blockSizeHorizontal! * 8,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/icon/profile/toko.png"))),
                                    ),
                                    SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal! * 2,
                                    ),
                                    Flexible(
                                      child: Text(data!.namaProduk!,
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal! *
                                                  2,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.blockSizeHorizontal! * 2),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: Column(
                              children: [
                                HargaItem(
                                    title: "Harga Jual Umum",
                                    harga: data?.hargaUmum ?? "0"),
                                HargaItem(
                                    title: "Harga Jual Grosir",
                                    harga: data?.hargaGrosir ?? "0"),
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

  FutureBuilder<dynamic> totalItem(ProdukProvider produkProvider) {
    return FutureBuilder(
      future: produkProvider.getProduk(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Total Item : ",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: Text('0',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal! * 2)),
              )
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Total Item : ",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: Text('${snapshot.data.length}',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal! * 2)),
              )
            ],
          );
        }
      },
    );
  }

  FutureBuilder<dynamic> dropdownkatakunci(ProdukProvider produkProvider) {
    return FutureBuilder(
      future: produkProvider.getProduk(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kata Kunci : ",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
              Expanded(
                child: Container(
                  // width: SizeConfig.screenWidth! * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: FittedBox(
                        child: Text("Nama Produk",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal! * 2)),
                      ),
                      isExpanded: true,
                      value: choosenKey,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      items: ["Belum ada Produk"]
                          .map<DropdownMenuItem<String>>((item) =>
                              DropdownMenuItem<String>(
                                  value: item.toString(),
                                  child: Text("$item",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal! *
                                                  2))))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          choosenKey = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          List<Produk> data = snapshot.data;
          List dataDropDown = [];
          for (int i = 0; i < data.length; i++) {
            dataDropDown.add(data[i].namaProduk);
          }
          dataDropDown = dataDropDown.toSet().toList();
          print(dataDropDown);
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kata Kunci : ",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
              Expanded(
                child: Container(
                  // width: SizeConfig.screenWidth! * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: FittedBox(
                        child: Text("Nama Produk",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal! * 2)),
                      ),
                      isExpanded: true,
                      value: choosenKey,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      items: dataDropDown
                          .map<DropdownMenuItem<String>>((item) =>
                              DropdownMenuItem<String>(
                                  value: item.toString(),
                                  child: Text("$item",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal! *
                                                  2))))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          choosenKey = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
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
          dialogProduk(context: context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle,
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 2,
            ),
            Text("Tambah Produk",
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2))
          ],
        ));
  }

  Future<dynamic> dialogProduk({required BuildContext context, Produk? item}) {
    var produkProvider = Provider.of<ProdukProvider>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding:
                  EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
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
                          item: item?.kodeProduk.toString() ?? '',
                        ),
                        InputProduk(
                          title: "Nama Barang",
                          controller: namaCtrl,
                          item: item?.namaProduk ?? '',
                        ),
                        InputProduk(
                          title: "Kategori Barang",
                          controller: kategoriCtrl,
                          item: item?.typeProduk ?? '',
                        ),
                        InputProduk(
                          title: "Harga Grosir",
                          controller: hargaUmumCtrl,
                          item: item?.typeProduk ?? '',
                        ),
                        InputProduk(
                          title: "Harga Umum",
                          controller: hargaGrosirCtrl,
                          item: item?.typeProduk ?? '',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 2,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal! * 2,
                                    vertical:
                                        SizeConfig.blockSizeVertical! * 2)),
                            onPressed: () {
                              produkProvider.addProduk(
                                  kodeCtrl.text,
                                  namaCtrl.text,
                                  kategoriCtrl.text,
                                  hargaUmumCtrl.text,
                                  hargaGrosirCtrl.text,
                                  context);
                              // setState(() {
                              //   _items.add(Produk(
                              //       kode: int.parse(kodeCtrl.text),
                              //       nama: namaCtrl.text,
                              //       kategori: kategoriCtrl.text,
                              //       isSelected: false));
                              //   dropdownitem =
                              //       _generateDropdownKategori(_items);
                              // });
                              // kodeCtrl.clear();
                              // namaCtrl.clear();
                              // kategoriCtrl.clear();
                              // Navigator.pop(context);
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
                        padding: const EdgeInsets.all(0),
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
                    // Column(children: [
                    //   Container(
                    //     height: 150,
                    //     width: 150,
                    //     decoration: BoxDecoration(
                    //         image: const DecorationImage(
                    //             image: AssetImage("assets/icon/profile.png")),
                    //         border: Border.all()),
                    //   ),
                    //   const SizedBox(height: 10),
                    //   ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 10, vertical: 10)),
                    //       onPressed: () {},
                    //       child: Row(
                    //         children: const [
                    //           Icon(Icons.cloud_upload_rounded),
                    //           SizedBox(
                    //             width: 20,
                    //           ),
                    //           Text("Upload Gambar ")
                    //         ],
                    //       ))
                    // ])
                  ],
                ),
              ),
            ));
  }

  FutureBuilder<dynamic> dataTableTransaksi(BuildContext context) {
    var produk = Provider.of<ProdukProvider>(context);
    return FutureBuilder(
      future: produk.getProduk(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            height: SizeConfig.screenHeight! * 0.55,
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                headingTextStyle: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal! * 2,
                    fontWeight: FontWeight.bold),
                dataTextStyle: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal! * 2,
                    color: Colors.black),
                headingRowColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) =>
                        Theme.of(context).primaryColor),
                decoration: const BoxDecoration(color: Colors.white),
                columns: _createColumns(),
                rows: List<DataRow>.from(
                    _items.map((item) => _createRow(item)).toList()),
              ),
            ),
          );
        } else {
          // print(snapshot.data);
          // var dataProduk = snapshot.data;
          _items = snapshot.data;
          _generateDropdownKategori(_items);
          return SizedBox(
            height: SizeConfig.screenHeight! * 0.65,
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                headingTextStyle: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal! * 2,
                    fontWeight: FontWeight.bold),
                dataTextStyle: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal! * 2,
                    color: Colors.black),
                headingRowColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) =>
                        Theme.of(context).primaryColor),
                decoration: const BoxDecoration(color: Colors.white),
                columns: _createColumns(),
                rows: List<DataRow>.from(
                    _items.map((item) => _createRow(item)).toList()),
              ),
            ),
          );
        }
      },
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text(
          'Kode',
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.7),
        ),
        numeric: false,
      ),
      DataColumn(
        label: Text(
          'Nama Barang',
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.7),
        ),
        numeric: false,
        tooltip: 'Name of the item',
      ),
      DataColumn(
        label: Text(
          'Kategori',
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.7),
        ),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
    ];
  }

  DataRow _createRow(Produk item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.id),
      selected: item.isSelected!,
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
            item.kodeProduk!,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.7),
          ),
        ),
        DataCell(
          Text(
            item.namaProduk!,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.7),
          ),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            dialogProduk(context: context, item: item);
          },
        ),
        DataCell(Text(
          item.typeProduk!,
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.7),
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
    FocusNode _focusNode = FocusNode();
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(title!,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        ),
        SizedBox(
            width: 300,
            child: TextFormField(
              focusNode: _focusNode,
              controller: controller,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2),
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
            child: Text(title!,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal! * 1.5))),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 2)),
            child: Text(harga!,
                style:
                    TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.5)),
          ),
        )
      ],
    );
  }
}
