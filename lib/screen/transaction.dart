import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';

import '../model/item_model.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  String _scanBarcode = "Unknows";
  String? chooseHarga;
  int item = 5;
  bool isSelected = false;
  bool isSearch = false;
  List<Item> _items = [];

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _items = _generateItems();
  //   });
  // }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    List<Item> data = [];
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      data.add(Item(
          id: int.parse(barcodeScanRes),
          name: "Item Tet",
          total: 1,
          price: 1000,
          totalPrice: 2000,
          isSelected: false));
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

  List<Item> _generateItems() {
    return List.generate(10, (int index) {
      return Item(
        id: index + 2,
        name: 'Item ${index + 1}',
        price: (index + 1) * 1000.00,
        total: 2,
        totalPrice: 2000,
        isSelected: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "Transaksi Baru", context: context),
      drawer: const DrawerMain(),
      body: ListView(children: [
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
                          dropdownHarga(),
                          searchBar(context),
                          navbarMain()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      dataTableTransaksi(context),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ButtonTambahItem(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Total(
                                title: "Grand Total",
                                child: Text("Rp 2.000.000.000",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                              Total(title: "Tunai", child: TextFormField()),
                              Total(
                                  title: "Kembali",
                                  child: Text("Rp. 9000000",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                              fontWeight: FontWeight.bold))),
                              const SizedBox(
                                height: 10,
                              ),
                              const ButtomBayar(),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            const BonTransaksi(),
          ],
        )
      ]),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('No'),
        numeric: true,
      ),
      const DataColumn(
        label: Text('Nama Barang'),
        numeric: false,
        tooltip: 'Name of the item',
      ),
      const DataColumn(
        label: Text('Jumlah'),
        numeric: false,
        tooltip: 'Total of the item',
      ),
      const DataColumn(
        label: Text('Harga'),
        numeric: false,
        tooltip: 'Price of the item',
      ),
      const DataColumn(
        label: Text('Total Harga'),
        numeric: false,
        tooltip: 'Total Price of the item',
      ),
    ];
  }

  DataRow _createRow(Item item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.id),
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
            item.id.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        DataCell(
          Text(
            item.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            print('onTap');
          },
        ),
        DataCell(Text(
          item.total.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )),
        DataCell(
          Text(
            item.price.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        DataCell(
          Text(
            item.totalPrice.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }

  SizedBox dataTableTransaksi(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
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

  Visibility navbarMain() {
    return Visibility(
      visible: !isSearch,
      child: Row(
        children: [
          ButtonNavbar(
            title: "Scan Barang",
            icon: Icons.document_scanner_outlined,
            onPressed: () {
              scanBarcodeNormal();
            },
          ),
          const SizedBox(
            width: 10,
          ),
          ButtonNavbar(
            title: "Cari",
            icon: Icons.search,
            onPressed: () {
              setState(() {
                isSearch = true;
              });
            },
          ),
          const SizedBox(
            width: 10,
          ),
          ButtonNavbar(
            title: "Refresh",
            icon: Icons.refresh,
            onPressed: () {},
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
                SizedBox(
                    width: 400,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Silahkan Cari .."),
                    )),
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

  Row dropdownHarga() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Harga : ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Container(
          width: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: const Text("Pilih Harga"),
              isExpanded: true,
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
      ],
    );
  }
}

class ButtomBayar extends StatelessWidget {
  const ButtomBayar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.attach_money),
              const SizedBox(
                width: 50,
              ),
              Text(
                "Bayar",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
            ],
          )),
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
          width: 150,
          child: Text(title!,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 200,
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
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50), backgroundColor: Colors.white),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            Text(title!,
                style: TextStyle(color: Theme.of(context).primaryColor))
          ],
        ));
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
