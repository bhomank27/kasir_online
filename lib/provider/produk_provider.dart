import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:kasir_online/model/transaksi_model.dart';
import 'package:kasir_online/model/product_model.dart';

class ProdukProvider extends ChangeNotifier {
  int totalItem = 0;
  get produk => totalItem;

  addProduk(kode, name, type, hargaUmum, hargaGrosir, context) async {
    var url = Uri.parse('$baseUrl/produk');

    var response = await http.post(url, body: {
      "id_produk": kode,
      "kode_produk": kode,
      "nama_produk": name,
      "type_produk": type,
      "harga_umum": hargaUmum,
      "harga_grosir": hargaGrosir
    });

    print(response.body);
    if (response.statusCode == 201) {
      getProduk();
      Navigator.pop(context);
    }
    notifyListeners();
  }

  getProduk() async {
    var url = Uri.parse('$baseUrl/produk');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data']['data'];
      totalItem = data.length;
      List<Produk> produk = data.map((e) => Produk.fromJson(e)).toList();
      return produk;
    } else {
      <Produk>[];
    }
    notifyListeners();
  }

  Future getProdukById(id) async {
    var url = Uri.parse('$baseUrl/produk/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      Produk data = json.decode(response.body)['data'];
      return data;
    } else {
      <Produk>[];
    }
    notifyListeners();
  }
}
