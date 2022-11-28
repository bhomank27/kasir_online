import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kasir_online/model/product_model.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/drawer_main.dart';
import 'package:provider/provider.dart';

import '../provider/produk_provider.dart';
import '../theme/theme.dart';

class StokScreen extends StatefulWidget {
  const StokScreen({Key? key}) : super(key: key);

  @override
  State<StokScreen> createState() => _StokScreenState();
}

class _StokScreenState extends State<StokScreen> {
  List _items = [];
  Produk data = Produk(
      kodeProduk: "12345678",
      namaProduk: "- Nama Produk -",
      typeProduk: "none",
      isSelected: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "Stok Barang", context: context),
      drawer: const DrawerMain(),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    ButtonDashboard(
                      title: "Cari",
                      icon: Icons.search,
                    ),
                    ButtonDashboard(
                      title: "Daftar Expire",
                      icon: Icons.history,
                    ),
                    ButtonDashboard(
                      title: "Minimun Stok",
                      icon: Icons.paste,
                    ),
                    ButtonDashboard(
                      title: "Refresh",
                      icon: Icons.refresh,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: dataTableTransaksi(context)),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            color: Colors.red,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
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
                                        data.namaProduk!,
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
                )
              ],
            )),
      ),
    );
  }

  FutureBuilder<dynamic> dataTableTransaksi(BuildContext context) {
    var produk = Provider.of<ProdukProvider>(context);
    return FutureBuilder(
      future: produk.getProduk(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          _items = snapshot.data;
          return Container(
            margin: EdgeInsets.only(right: 20),
            height: MediaQuery.of(context).size.height / 1.5,
            child: SingleChildScrollView(
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
      const DataColumn(
        label: Text('Nama Barang'),
        numeric: false,
      ),
      const DataColumn(
        label: Text('Total Stok'),
        numeric: false,
        tooltip: 'Stock of the item',
      ),
      const DataColumn(
        label: Text('Action'),
        numeric: false,
        tooltip: 'Action of the item',
      ),
    ];
  }

  DataRow _createRow(item) {
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
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        DataCell(
          Text(
            item.namaProduk!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            // dialogProduk(context: context, item: item);
          },
        ),
        DataCell(Text(
          item.typeProduk!,
          style: Theme.of(context).textTheme.subtitle1,
        )),
      ],
    );
  }
}

class ButtonDashboard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  void Function()? ontap;
  ButtonDashboard({super.key, this.title, this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Expanded(
      child: GestureDetector(
        onTap: ontap ?? () {},
        child: SizedBox(
          width: 250,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(title!,
                      style: style.headline2!
                          .copyWith(color: Theme.of(context).primaryColor))
                ],
              ),
            ),
          ),
        ),
      ),
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
