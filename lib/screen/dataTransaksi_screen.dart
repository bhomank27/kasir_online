import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kasir_online/model/transaksi_model.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';

import '../model/dataTransaksi_model.dart';

class DataTransaksiScreen extends StatefulWidget {
  const DataTransaksiScreen({super.key});

  @override
  State<DataTransaksiScreen> createState() => _DataTransaksiScreenState();
}

class _DataTransaksiScreenState extends State<DataTransaksiScreen> {
  List<DataTransaksi> _items = [];

  @override
  void initState() {
    super.initState();
    _items = _generateProduks();
  }

  List<DataTransaksi> _generateProduks() {
    return List.generate(20, (int index) {
      return DataTransaksi(
          tanggal: "12-12-2022" + index.toString(),
          pukul: "20:59",
          namaBarang: "Pop Mie",
          harga: 10.000,
          banyakBarang: 1,
          total: 10000,
          keterangan: "Lunas",
          isSelected: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "Data Transaksi", context: context),
      drawer: DrawerMain(),
      body: Container(
        margin: EdgeInsets.all(30),
        child: ListView(children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Cari Disini", border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ),
          dataTableTransaksi(context),
        ]),
      ),
    );
  }

  DataRow _createRow(DataTransaksi item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.tanggal),
      selected: item.isSelected,
      onSelectChanged: (bool? isSelected) {
        if (isSelected != null) {
          item.isSelected = isSelected;

          // setState(() {
          //   data = item;
          // });

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
            item.tanggal,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        DataCell(
          Text(
            item.pukul,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            // dialogProduk(context: context, item: item);
          },
        ),
        DataCell(Text(
          item.namaBarang.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )),
        DataCell(Text(
          item.harga.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )),
        DataCell(Text(
          item.banyakBarang.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )),
        DataCell(Text(
          item.total.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )),
        DataCell(Container(
          padding: EdgeInsets.all(10),
          color: Colors.green,
          child: Text(
            item.keterangan.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
        )),
      ],
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('Tanggal'),
        numeric: true,
      ),
      const DataColumn(
        label: Text('Pukul'),
        numeric: false,
        tooltip: 'Name of the item',
      ),
      const DataColumn(
        label: Text('Nama Barang'),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      const DataColumn(
        label: Text('Harga'),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      const DataColumn(
        label: Text('Banyak'),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      const DataColumn(
        label: Text('Total'),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      DataColumn(
        label: Text("Keterangan"),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
    ];
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
}
