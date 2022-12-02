import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/model/transaksi_model.dart';
import 'package:kasir_online/provider/transaksi_provider.dart';
import 'package:kasir_online/screen/transaction_screen.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';
import 'package:provider/provider.dart';

import '../model/dataTransaksi_model.dart';

class DataTransaksiScreen extends StatefulWidget {
  const DataTransaksiScreen({super.key});

  @override
  State<DataTransaksiScreen> createState() => _DataTransaksiScreenState();
}

class _DataTransaksiScreenState extends State<DataTransaksiScreen> {
  List<Transaksi> _items = [];

  @override
  void initState() {
    super.initState();
    _items = _generateTransaksi();
  }

  List<Transaksi> _generateTransaksi() {
    return List.generate(_items.length, (int index) {
      return Transaksi(
          id: _items[index].id,
          id_user: _items[index].id_user,
          totalBayar: _items[index].totalBayar,
          tunai: _items[index].totalBayar.toString(),
          kembali: _items[index].kembali,
          keterangan: "lunas",
          isSelected: false,
          createdAt: _items[index].createdAt);
    });
  }

  @override
  Widget build(BuildContext context) {
    var transaksiProvider =
        Provider.of<TransaksiProvider>(context, listen: false);
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
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal! * 2),
                    decoration: InputDecoration(
                        hintText: "Cari Disini",
                        hintStyle: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal! * 2),
                        border: InputBorder.none),
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
          dataTableTransaksi(context, transaksiProvider),
        ]),
      ),
    );
  }

  DataRow _createRow(Transaksi item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.id),
      selected: item.isSelected!,
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
            item.createdAt!,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2),
          ),
        ),
        DataCell(
          Text(item.createdAt!,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            // dialogProduk(context: context, item: item);
          },
        ),
        DataCell(Text(item.namaProduk!,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2))),
        DataCell(Text(item.hargaProduk.toString(),
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2))),
        DataCell(Text('1',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2))),
        DataCell(Text(item.totalBayar.toString(),
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2))),
        DataCell(Container(
          padding: EdgeInsets.all(10),
          color: Colors.green,
          child: Text(item.keterangan.toString(),
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal! * 2,
                  color: Colors.white)),
        )),
      ],
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text('Tanggal',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        numeric: false,
      ),
      DataColumn(
        label: Text('Pukul',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        numeric: false,
        tooltip: 'Name of the item',
      ),
      DataColumn(
        label: Text('Nama Barang',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      DataColumn(
        label: Text('Harga',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      DataColumn(
        label: Text('Banyak',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      DataColumn(
        label: Text('Total',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
      DataColumn(
        label: Text("Keterangan",
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
        numeric: false,
        tooltip: 'Kategori of the item',
      ),
    ];
  }

  Widget dataTableTransaksi(
      BuildContext context, TransaksiProvider transaksiProvider) {
    return FutureBuilder(
      future: transaksiProvider.getTransaksi(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print("snapshot.data Transaksi >> ${snapshot.data}");
        if (!snapshot.hasData) {
          return SizedBox(
            height: SizeConfig.screenHeight! * 0.7,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showCheckboxColumn: false,
                headingTextStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                headingRowColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) =>
                        Theme.of(context).primaryColor),
                decoration: const BoxDecoration(color: Colors.white),
                columns: _createColumns(),
                rows: _items.map((item) => _createRow(item)).toList(),
              ),
            ),
          );
        } else {
          
          _generateTransaksi();
          return SizedBox(
            height: SizeConfig.screenHeight! * 0.7,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showCheckboxColumn: false,
                headingTextStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                headingRowColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) =>
                        Theme.of(context).primaryColor),
                decoration: const BoxDecoration(color: Colors.white),
                columns: _createColumns(),
                rows: _items.map((item) => _createRow(item)).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}
