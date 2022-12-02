import 'dart:async';
import 'package:flutter/material.dart';
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

  clearController() {
    setState(() {
      kodeCtrl.clear();
      namaCtrl.clear();
      kategoriCtrl.clear();
      hargaUmumCtrl.clear();
      hargaGrosirCtrl.clear();
    });
  }

  Future<void> scanBarcodeNormal(context) async {
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Gagal Scan Barcode")));
    }
    if (!mounted) return;
    setState(() {
      kodeCtrl.text = barcodeScanRes!;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ProdukProvider>(context, listen: false);
      // provider.allProduk = [];
      provider.getProduk();
      provider.getKategori();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarWidget(title: "Produk", context: context),
      drawer: const DrawerMain(),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 1.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Expanded(child: dropdownkatakunci()),
                                      Expanded(child: totalItem()),
                                    ],
                                  ),
                                ),
                                dataTableProduk(context),
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
            ),
          );
        },
      ),
    );
  }

  Widget totalItem() {
    return Consumer<ProdukProvider>(
      builder: (BuildContext context, produkProvider, Widget? child) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Total Item : ",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 2)),
            child: Text('${produkProvider.allProduk.length}',
                style:
                    TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
          )
        ],
      ),
    );
  }

  Widget dropdownkatakunci() {
    return Consumer<ProdukProvider>(
      builder: (BuildContext context, produkProvider, Widget? child) => Row(
        children: [
          Text("Kata Kunci : ",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
          Expanded(
            child: Container(
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
                  items: produkProvider.kategori
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

  dialogProduk({required BuildContext context, Produk? item}) {
    if (item != null) {
      kodeCtrl.text = item.kodeProduk!;
      namaCtrl.text = item.namaProduk!;
      kategoriCtrl.text = item.typeProduk!;
      hargaGrosirCtrl.text = item.hargaGrosir!;
      hargaUmumCtrl.text = item.hargaUmum!;
    }
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
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text("Kode Barang",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 2)),
                            ),
                            SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: kodeCtrl,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 2),
                                  decoration:
                                      const InputDecoration(hintText: ""),
                                ))
                          ],
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
                              Provider.of<ProdukProvider>(context,
                                      listen: false)
                                  .addProduk(
                                      kodeCtrl.text,
                                      namaCtrl.text,
                                      kategoriCtrl.text,
                                      hargaUmumCtrl.text,
                                      hargaGrosirCtrl.text);

                              Navigator.pop(context);
                              Timer(const Duration(seconds: 1),
                                  () => clearController());
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
                          scanBarcodeNormal(context);
                        },
                        icon: const Icon(
                          Icons.document_scanner_outlined,
                          color: Colors.red,
                          size: 50,
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget dataTableProduk(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.55,
      child: SingleChildScrollView(
        child: Consumer<ProdukProvider>(
          builder: (BuildContext context, produkProvider, Widget? child) =>
              DataTable(
            showCheckboxColumn: false,
            headingTextStyle: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal! * 2,
                fontWeight: FontWeight.bold),
            dataTextStyle: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal! * 2,
                color: Colors.black),
            headingRowColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) => Theme.of(context).primaryColor),
            decoration: const BoxDecoration(color: Colors.white),
            columns: _createColumns(),
            rows: List<DataRow>.from(
                produkProvider.produk.map((item) => _createRow(item)).toList()),
          ),
        ),
      ),
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
