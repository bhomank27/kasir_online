import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/model/product_model.dart';
import 'package:kasir_online/model/transaksi_model.dart';
import 'package:kasir_online/provider/produk_provider.dart';
import 'package:kasir_online/provider/transaksi_provider.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../model/item_model.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  Size? size;
  String _scanBarcode = "Unknows";
  Transaksi selected = Transaksi(
    namaProduk: " Tambah Produk",
  );
  String? chooseHarga;
  int item = 5;
  bool isSelected = false;
  bool isSearch = false;
  double total = 0;
  int kembali = 0;
  List<Transaksi> _items = [];
  FloatingActionButtonLocation? position =
      FloatingActionButtonLocation.endFloat;
  ScrollController scrollController = ScrollController();
  var tunaiCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    handleScroll();
    // setState(() {
    //   _items = _generateItems();
    // });
  }

  Future<void> scanBarcodeNormal(ProdukProvider produkProvider) async {
    String barcodeScanRes;
    List<Transaksi> data = [];
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      if (barcodeScanRes != '-1') {
        produkProvider.getProdukById(barcodeScanRes).then((value) => _items.add(
            Transaksi(
                id: value.id,
                namaProduk: value.namaProduk,
                hargaProduk: double.parse(value.hargaUmum!),
                jumlah: 1,
                totalBayar: double.parse(value.hargaUmum!),
                isSelected: false)));
        // data.add(Item(
        //     id: int.parse(barcodeScanRes),
        //     name: "Item Tet",
        //     total: 1,
        //     price: 1000,
        //     totalPrice: 2000,
        //     isSelected: false));
      }
      print(data);
      // player.play('beep.mp3');
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _items += data;
    });
  }

  Future<void> startBarcodeScanStream() async {
    List data = [];
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen(
      (barcode) {
        // print(barcode);
        data.add(barcode);
      },
    );
  }

  List<Transaksi> _generateItems() {
    return List.generate(_items.length, (int index) {
      return Transaksi(
        id: _items[index].id,
        namaProduk: _items[index].namaProduk,
        hargaProduk: _items[index].hargaProduk,
        jumlah: _items[index].jumlah,
        totalBayar: _items[index].totalBayar,
        isSelected: _items[index].isSelected,
      );
    });
  }

  kembaliFunc() {
    if (tunaiCtrl.text == '') {
      return 0;
    } else {
      return total - int.parse(tunaiCtrl.text);
    }
  }

  void changePosition(FloatingActionButtonLocation values) {
    setState(() {
      position = values;
    });
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.offset > 300) {
        changePosition(FloatingActionButtonLocation.startFloat);
      }
      if (scrollController.offset == 0) {
        changePosition(FloatingActionButtonLocation.endFloat);
      }
    });
  }

  void scrollBottom(height) {
    scrollController.animateTo(height,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void scrollTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void clear() {
    setState(() {
      total = 0;
      tunaiCtrl.clear();
      kembali = 0;
      _items.clear();
      selected = Transaksi(
        namaProduk: " Tambah Produk",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var produkProvider = Provider.of<ProdukProvider>(context);
    var transaksiProvider = Provider.of<TransaksiProvider>(context);
    size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButtonLocation: position,
      appBar: appbarWidget(title: "Transaksi Baru", context: context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scrollController.offset == 0) {
            scrollBottom(size!.height);
          } else {
            scrollTop();
          }
        },
        child: position == FloatingActionButtonLocation.endFloat
            ? const Icon(Icons.attach_money_outlined)
            : const Icon(Icons.arrow_upward_rounded),
      ),
      drawer: const DrawerMain(),
      body: ListView(controller: scrollController, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 1, child: dropdownHarga()),
                          searchBar(context),
                          Expanded(flex: 2, child: navbarMain(produkProvider))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      dataTableTransaksi(
                        context,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Total(
                                title: "Grand Total",
                                child: Text(
                                  "Rp $total",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal! * 2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Total(
                                  title: "Tunai",
                                  child: Row(
                                    children: [
                                      Text(
                                        "Rp ",
                                        style: TextStyle(
                                            fontSize: SizeConfig
                                                    .safeBlockHorizontal! *
                                                2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: tunaiCtrl,
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          decoration: const InputDecoration(),
                                        ),
                                      )
                                    ],
                                  )),
                              Total(
                                  title: "Kembali",
                                  child: Text(
                                    "Rp. ${kembaliFunc()}",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! * 2,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              buttonBayar(context, transaksiProvider)
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            // const BonTransaksi(),
          ],
        )
      ]),
    );
  }

  SizedBox buttonBayar(
      BuildContext context, TransaksiProvider transaksiProvider) {
    return SizedBox(
      width: SizeConfig.screenWidth! * 0.53,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
          onPressed: () {
            if (_items.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Silahkan Pilih Produk")));
            }
            if (tunaiCtrl.text == '') {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Selesaikan Transaksi")));
            } else if (int.parse(tunaiCtrl.text) < total) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          "Uang Tunai Kurang dari Grand Total",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal! * 2,
                              fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          "Lanjutkan?",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal! * 2,
                              fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                loading(context);
                                Future.delayed(const Duration(seconds: 2), () {
                                  clear();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Transaksi Berhasil",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! * 2,
                                        fontWeight: FontWeight.bold),
                                  )));
                                  scrollTop();
                                });
                              },
                              child: Text(
                                "Ya",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal! * 2,
                                    fontWeight: FontWeight.bold),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tidak"))
                        ],
                      ));
            } else {
              transaksiProvider.addTransaksi(
                  total.toString(), kembali.toString(), tunaiCtrl.text);
              loading(context);
              Timer(const Duration(seconds: 2), () {
                clear();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Transaksi Berhasil")));
                scrollTop();
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.attach_money),
              const SizedBox(
                width: 50,
              ),
              Text(
                "Bayar",
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal! * 2,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }

  Future<dynamic> loading(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircularProgressIndicator.adaptive(),
            )));
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text(
          'Nama Barang',
          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 1.8),
        ),
        numeric: false,
        tooltip: 'Name of the item',
      ),
      DataColumn(
        label: Text(
          'Jumlah',
          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 1.8),
        ),
        numeric: false,
        tooltip: 'Total of the item',
      ),
      DataColumn(
        label: Text(
          'Harga',
          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 1.8),
        ),
        numeric: false,
        tooltip: 'Price of the item',
      ),
      DataColumn(
        label: Text(
          'Total Harga',
          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 1.8),
        ),
        numeric: false,
        tooltip: 'Total Price of the item',
      ),
    ];
  }

  DataRow _createRow(Transaksi item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.id),
      selected: item.isSelected!,
      onSelectChanged: (bool? isSelected) {
        if (isSelected != null) {
          print(item.isSelected);
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
            item.namaProduk!,
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 2),
          ),
        ),
        DataCell(Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    item.jumlah = item.jumlah! + 1;
                    item.totalBayar = item.totalBayar! + item.hargaProduk!;
                    total = total + item.totalBayar!;
                  });
                },
                icon: const Icon(Icons.add)),
            Text(
              item.jumlah.toString(),
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 2),
            ),
            IconButton(
                onPressed: () {
                  if (item.jumlah! <= 1) {
                    setState(() {
                      _items.removeWhere((element) => element.id == item.id);
                      total = total - item.totalBayar!;
                    });
                  } else {
                    setState(() {
                      item.jumlah = item.jumlah! - 1;
                      item.totalBayar = item.totalBayar! - item.hargaProduk!;
                      total = total - item.totalBayar!;
                    });
                  }
                },
                icon: const Icon(Icons.remove)),
          ],
        )),
        DataCell(
          Text(
            "${item.hargaProduk}",
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 2),
          ),
        ),
        DataCell(
          Text(
            item.totalBayar.toString(),
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 2),
          ),
        ),
      ],
    );
  }

  SizedBox dataTableTransaksi(
    BuildContext context,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
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

  Visibility navbarMain(ProdukProvider produkProvider) {
    return Visibility(
      visible: !isSearch,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder(
            future: produkProvider.getProduk(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Expanded(
                  child: Card(
                    color: Colors.white,
                    child: DropdownSearch<Produk>(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        textAlignVertical: TextAlignVertical.center,
                        dropdownSearchDecoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                      popupProps: PopupProps.dialog(
                          fit: FlexFit.loose,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal! * 1.5)),
                          itemBuilder: ((context, produk, isSelected) =>
                              ListTile(
                                title: Text(
                                  produk.namaProduk!,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal! *
                                              1.5),
                                ),
                              ))),
                      items: snapshot.data,
                      onChanged: ((produk) {
                        print(produk);
                        if (_items.any((element) => element.id == produk!.id)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Produk Sudah Ada")));
                        } else {
                          Transaksi data = Transaksi(
                              id: produk!.id,
                              namaProduk: produk.namaProduk,
                              hargaProduk: double.parse(produk.hargaUmum!),
                              jumlah: 1,
                              totalBayar: double.parse(produk.hargaUmum!) * 1,
                              isSelected: false);

                          _items.add(data);
                          setState(() {
                            total = total + double.parse(produk.hargaUmum!);
                            _generateItems();
                          });

                          print(_items);
                        }
                      }),
                      dropdownBuilder: ((context, selectedItem) => Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal! * 2),
                            child: Text(
                              selectedItem?.namaProduk ?? 'Tambah Produk',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal! * 1.5),
                            ),
                          )),
                      // selectedItem: selected,
                    ),
                  ),
                );
              }
            },
          ),
          Expanded(
            child: ButtonNavbar(
              title: "Scan Barang",
              icon: Icons.document_scanner_outlined,
              onPressed: () {
                scanBarcodeNormal(produkProvider);
              },
            ),
          ),
          Expanded(
            child: ButtonNavbar(
              title: "Cari",
              icon: Icons.search,
              onPressed: () {
                setState(() {
                  isSearch = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Visibility searchBar(BuildContext context) {
    return Visibility(
        visible: isSearch,
        child: Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                      child: TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Silahkan Cari .."),
                  )),
                ),
                Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = false;
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ))
              ],
            ),
          ),
        ));
  }

  Widget dropdownHarga() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            width: SizeConfig.screenWidth! * 0.3,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  "Pilih Harga",
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal! * 1.5),
                ),
                value: chooseHarga,
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                items: [
                  {"key": "Umum"},
                  {"key": "warungan"}
                ]
                    .map<DropdownMenuItem<String>>((item) =>
                        DropdownMenuItem<String>(
                            value: item.toString(),
                            child: Text("${item['key']}",
                                style: const TextStyle(color: Colors.black))))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    chooseHarga = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonTambahItem extends StatelessWidget {
  const ButtonTambahItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
          onPressed: () {},
          child: const Text("+ Tambah Item", style: TextStyle(fontSize: 20))),
    );
  }
}

class Total extends StatelessWidget {
  Widget? child;
  String? title;
  Total({Key? key, required this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 30.w,
          child: Text(
            title!,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal! * 2,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 60.w,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2)),
          child: Center(
            child: child,
          ),
        )
      ],
    );
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

class ButtonNavbar extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final void Function()? onPressed;
  const ButtonNavbar({
    Key? key,
    this.title,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal! * 0.5,
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 50), backgroundColor: Colors.white),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              Text(title!,
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                      color: Colors.red))
            ],
          )),
    );
  }
}

class BonTransaksi extends StatelessWidget {
  const BonTransaksi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            // color: Colors.green,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  offset: Offset(-2, 2),
                  color: Color.fromARGB(255, 169, 169, 169))
            ]),
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 30),
                  child: Text("Keranjang Belanja",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.80,
                  child: ListView.separated(
                    itemCount: 3,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 10,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Abc kecap",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("1", style: TextStyle(fontSize: 16)),
                              Text("Rp.12.000", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            children: const [
                              Text("2.400", style: TextStyle(fontSize: 16))
                            ],
                          ),
                          Row(
                            children: const [
                              Text("Laba : 2.000",
                                  style: TextStyle(fontSize: 16))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RawMaterialButton(
                                constraints:
                                    const BoxConstraints(maxHeight: 20),
                                onPressed: () {},
                                shape: const CircleBorder(),
                                fillColor: Theme.of(context).primaryColor,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              RawMaterialButton(
                                padding: const EdgeInsets.all(2),
                                constraints:
                                    const BoxConstraints(maxHeight: 30),
                                onPressed: () {},
                                shape: const CircleBorder(),
                                fillColor: Theme.of(context).primaryColor,
                                child: const Icon(
                                  Icons.file_copy,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Total",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Rp 10.400",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Tunai",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Rp 20.000",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Kembali",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Rp 9.600",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5)),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.print,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Cetak", style: TextStyle(fontSize: 20))
                      ],
                    ))
              ],
            )));
  }
}
