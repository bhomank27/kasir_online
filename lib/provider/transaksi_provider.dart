import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:kasir_online/model/transaksi_model.dart';
import 'package:kasir_online/storage/storage.dart';

import '../model/product_model.dart';

class TransaksiProvider extends ChangeNotifier {
  var storage = SecureStorage();

  List<Transaksi> keranjang = [];
  List<Transaksi>? allTransaksi = [];
  get transaksi => allTransaksi;
  double total = 0;
  double kembali = 0;

  addKeranjang(Produk produk) {
    keranjang.add(Transaksi(
        id: produk.id,
        namaProduk: produk.namaProduk,
        hargaProduk: double.parse(produk.hargaUmum!),
        jumlah: 1,
        totalBayar: double.parse(produk.hargaUmum!) * 1,
        isSelected: false));

    notifyListeners();
  }

  tambahTotalBayar() {}

  kurangiTotalBayar(double hargaProduk) {
    total -= hargaProduk;
    notifyListeners();
  }

  kembaliFunc(String tunai) {
    if (tunai == '') {
      kembali = 0;
      notifyListeners();
      return 0;
    } else {
      kembali = int.parse(tunai) - total;
      notifyListeners();
      return int.parse(tunai) - total;
    }
  }

  totalBayar(double hargaProduk) {
    total += hargaProduk;
    notifyListeners();
  }

  getTransaksi() async {
    var token = await storage.read('token');
    var url = Uri.parse("$baseUrl/transaksi");

    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      allTransaksi = data.map((data) => Transaksi.fromJson(data)).toList();
    }
  }

  Future<bool> addTransaksi(tunai) async {
    var token = await storage.read('token');
    var id = await storage.read('id');
    var url = Uri.parse("$baseUrl/transaksi");
    DateTime today = DateTime.now();

    var response = await http.post(url, body: {
      'id_user': id,
      'total_bayar': total,
      'tunai': double.parse(tunai),
      'kembali': kembali,
      'tgl_transaksi': today.toString(),
    }, headers: {
      "Authorization": "Bearer $token",
    });
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
