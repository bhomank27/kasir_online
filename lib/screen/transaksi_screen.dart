import 'package:flutter/material.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';

import '../model/item_model.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  String? chooseHarga;
  int item = 5;
  bool isSelected = false;
  bool isSearch = false;
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = _generateItems();
    });
  }

  List<Item> _generateItems() {
    return List.generate(10, (int index) {
      return Item(
        id: index + 1,
        name: 'Item ${index + 1}',
        price: index * 1000.00,
        description: 'Details of item ${index + 1}',
        isSelected: false,
      );
    });
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('No'),
        numeric: true,
      ),
      const DataColumn(
        label: Text('Name'),
        numeric: false,
        tooltip: 'Name of the item',
      ),
      const DataColumn(
        label: Text('Price'),
        numeric: false,
        tooltip: 'Price of the item',
      ),
      const DataColumn(
        label: Text('Description'),
        numeric: false,
        tooltip: 'Description of the item',
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
              ? Colors.red
              : Color.fromARGB(100, 215, 217, 219)),
      cells: [
        DataCell(
          Text(item.id.toString()),
        ),
        DataCell(
          Text(item.name),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            print('onTap');
          },
        ),
        DataCell(Text(item.price.toString())),
        DataCell(
          Text(item.description),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "Transaksi Baru"),
      drawer: const DrawerMain(),
      body: ListView(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
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
                          Visibility(
                              visible: isSearch,
                              child: Row(
                                children: [
                                  Container(
                                      width: 400,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "Silahkan Cari .."),
                                      )),
                                  const Icon(Icons.search),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isSearch = false;
                                        });
                                      },
                                      icon: const Icon(Icons.close))
                                ],
                              )),
                          Visibility(
                            visible: !isSearch,
                            child: Row(
                              children: [
                                ButtonNavbar(
                                  title: "Scan Barang",
                                  icon: Icons.document_scanner_outlined,
                                  onPressed: () {},
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
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: _createColumns(),
                            rows:
                                _items.map((item) => _createRow(item)).toList(),
                          ),
                        ),
                      ),

                      // datatableTransaksi(context),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 340,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(15)),
                                onPressed: () {
                                  setState(() {
                                    item += 1;
                                  });
                                },
                                child: const Text("+ Tambah Item",
                                    style: TextStyle(fontSize: 20))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Total(
                                title: "Grand Total",
                                child: const Text("Rp 2.000.000.000",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Total(title: "Tunai", child: TextFormField()),
                              Total(
                                  title: "Kembali",
                                  child: const Text("Rp. 9000000",
                                      style: TextStyle(fontSize: 20))),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 370,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(15)),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              ),
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

  SingleChildScrollView datatableTransaksi(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {"title": "ABC susu", "harga": "20000", "selected": true},
      {"title": "ABC susu", "harga": "20000", "selected": false},
      {"title": "ABC susu", "harga": "20000", "selected": false}
    ];
    return SingleChildScrollView(
        child: DataTable(
      headingTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      dataTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
      dataRowHeight: 50,
      headingRowColor:
          MaterialStateProperty.resolveWith((states) => Colors.red),
      decoration: const BoxDecoration(color: Colors.white),
      border: TableBorder.all(color: Colors.grey),
      columns: const [
        DataColumn(label: Text("Nomor"), numeric: true),
        DataColumn(label: Text("Nama Barang")),
        DataColumn(label: Text("Harga")),
      ],
      rows: data
          .map<DataRow>((data) => DataRow(
                  selected: data['selected'],
                  onSelectChanged: ((value) => setState(() {
                        data['selected'] = value;
                      })),
                  cells: [
                    const DataCell(Text("1")),
                    DataCell(Text(data['title']!)),
                    DataCell(Text(data['harga']!))
                  ]))
          .toList(),
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
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              color: Colors.red,
            ),
            Text(title!, style: const TextStyle(color: Colors.red))
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
                                fillColor: Colors.red,
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
                                fillColor: Colors.red,
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
